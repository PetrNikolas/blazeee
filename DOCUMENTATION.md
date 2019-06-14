# DOCUMENTATION

## Ecto Best Practices

### Avoiding N+1 Queries

In general, you want to make sure that when accessing Ecto associations that you preload the data in the top level resolver functions to avoid N+1 queries.

Imagine this scenario: You have posts and users. A Post has an author field, which returns a user. You want to list all posts, and get the name of their author:

```sh
{
  posts {
    author {
      name
    }
  }
}
```

If you write your schema like this, you’re going to have a bad time due to issues with N + 1:

```sh
object :post do
  @desc "Author of the post"
  field :author, :user do
    resolve fn post, _, _ ->
      author =
        post
        |> Ecto.assoc(:author)
        |> Repo.one

      {:ok, author}
    end
  end
end

query do
  field :posts, list_of(:post) do
    resolve fn _, _ ->
      {:ok, Post |> Repo.all}
    end
  end
end
```

What this schema will do when presented with the GraphQL query is run Post |> Repo.all, which will retrieve N posts. Then for each post it will resolve child fields, which runs our Repo.one query function, resulting in N+1 calls to the database.

One way to handle this issue is with Absinthe’s support for batching. The idea with batching is that we’re gonna aggregate all the author_ids from each post, and then make one call to the user.

Let’s first make a function to get a model by ids:

```sh
defmodule MyAppWeb.Schema.Helpers do
  def by_id(model, ids) do
    import Ecto.Query

    ids = ids |> Enum.uniq

    model
    |> where([m], m.id in ^ids)
    |> Repo.all
    |> Map.new(&{&1.id, &1})
  end
end
```

Now we can use this function to batch our author lookups:

```sh
object :post do

  @desc "Author of the post"
  field :author, :user do
    resolve fn post, _, _ ->
      batch({MyAppWeb.Schema.Helpers, :by_id, User}, post.author_id, fn batch_results ->
        {:ok, Map.get(batch_results, post.author_id)}
      end)
    end
  end

end
```

Now we make just two calls to the database. The first call loads all of the posts. Then as Absinthe walks through each post and tries to get the author, it’s instead told to aggregate its information.

That aggregate information is passed on to our by_id/2 function from earlier. It grabs ALL the users in just one database call, and creates a map of user ids to users.

Absinthe then does a second pass and calls the batch_results function with that map, letting us retrieve the individual author for each post.

Not only is this a very efficient way to query the data, it’s also 100% dynamic. If a query document asks for authors, they’re loaded efficiently. If it does not, they aren’t loaded at all.

We’ve made it easier and more flexible, however, with Elixir’s dataloader package.

### Dataloader

`Absinthe.Middleware.Batch` achieves a lot and, with some helpers, was the standard way to solve this problem for a long time. While batching still has a place, it has a few limitations that have driven the development of Dataloader. There are small scale annoyances like the limitation of only being able to batch one thing at a time in a field, or the fact that the API can get very verbose.

There’s also some larger scale issues however. Ecto has a fair number of quirks that make it a difficult library to abstract access to. If you want the concurrent test system to work, you need to add self() to all the batch keys and do `Repo.all(caller: pid)` in every batch function so that it knows which sandbox to use. It gets very easy for your GraphQL functions to become full of direct database access, inevitably going around important data access rules you may want to enforce in your contexts. Alternatively, your context functions can end up with dozens of little functions that only exist to support batching items by ID.

In time, people involved in larger projects have been able to build some abstractions, helpers, and conventions around the `Absinthe.Middleware.Batch` plugin that have done a good job of addressing these issues. That effort has been extracted into the Dataloader project, which also draws inspiration from similar projects in the GraphQL world.

#### Getting Started

Let’s jump straight in to getting Dataloader working, and then we’ll expand on what’s actually happening behind the scenes.

Using Dataloader is as simple as doing:

```sh
import Absinthe.Resolution.Helpers, only: [dataloader: 1]

object :author do
  @desc "Author of the post"
  field :posts, list_of(:post), resolve: dataloader(Blog)
end
```

To make this work we need to setup a dataloader, add the Blog source to it, and make sure our schema knows it needs to run the dataloader.

First however make sure to include the dataloader dependency in your application:

```sh
{:dataloader, "~> 1.0.0"}
```

Latest install instructions found here: [https://github.com/absinthe-graphql/dataloader](https://github.com/absinthe-graphql/dataloader)

Let’s start with a data source. Dataloader data sources are just structs that encode a way of retrieving data in batches. In a Phoenix application you’ll generally have one source per context, so that each context can control how its data is loaded.

Here is a hypothetical Blog context and a dataloader ecto source:

```sh
defmodule MyApp.Blog do
  def data() do
    Dataloader.Ecto.new(MyApp.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
```

When integrating Dataloader with GraphQL, we want to place it in our context so that we can access it in our resolvers. In your schema module add:

```sh
alias MyApp.{Blog, Foo}

def context(ctx) do
  loader =
    Dataloader.new
    |> Dataloader.add_source(Blog, Blog.data())
    |> Dataloader.add_source(Foo, Foo.data()) # Foo source could be a Redis source

  Map.put(ctx, :loader, loader)
end

def plugins do
  [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
end
```

The context/1 function is a callback specified by the Absinthe.Schema behaviour that gives the schema itself an opportunity to set some values in the context that it may need in order to run.

The plugins/0 function has been around for a while, and specifies what plugins the schema needs to resolve. See more here:

That’s it! If you run a GraphQL query that hits that field, it will be loaded efficiently without N+1.

#### Unpacking Dataloader

The `data/0` function creates an Ecto data source, to which you pass your repo and a query function. This query function is called every time you want to load something, and provides an opportunity to apply arguments or set defaults. So for example if you always want to only load non-deleted posts you can do:

```sh
def query(Post, _) do
  from p in Post, where: is_nil(p.deleted_at)
end
def query(queryable, _) do
  queryable
end
```

Now any time you’re loading posts, you’ll just get posts that haven’t been deleted. Helpfully, this rule is defined within your context, helping ensure that it has the final say about data access.

To actually use this data source we need to add a loader to your Absinthe Context:

```sh
defmodule MyAppWeb.Context do
  alias MyApp.Blog
  def dataloader() do
    Dataloader.new
    |> Dataloader.add_source(Blog, Blog.data())
  end
end
```
