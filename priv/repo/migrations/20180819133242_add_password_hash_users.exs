defmodule Api.Repo.Migrations.AddPasswordHashUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
        add :password_hash, :string
     end
  end
end
