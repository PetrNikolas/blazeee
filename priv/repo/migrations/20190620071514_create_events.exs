defmodule Api.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add(:event_type, :string)
      add(:message, :string)
      add(:payload, :text)

      timestamps()
    end
  end
end
