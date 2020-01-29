defmodule User do
  use Ecto.Schema

  embedded_schema do
    field(:name)
    field(:lastname)
    embeds_one(:company, Company)
  end
end
