defmodule Company do
  use Ecto.Schema

  embedded_schema do
    field(:name)
  end
end
