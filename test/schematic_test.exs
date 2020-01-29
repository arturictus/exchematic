defmodule SchematicTest do
  use ExUnit.Case
  doctest Schematic
  alias Schematic.Caster

  def get_changeset(%Company{} = changeset, params, :strict) do
    Caster.cast(Company, params)
    |> Ecto.Changeset.validate_required(:name)
  end

  test "cast/3" do
    assert %Ecto.Changeset{} = Caster.cast(%User{}, %{name: "John", lastname: "Doe"})
    assert %Ecto.Changeset{} = Caster.cast(User, %{name: "John", lastname: "Doe"})
  end

  test "cast/4" do
    assert %Ecto.Changeset{
             changes: %{
               company: %Ecto.Changeset{
                 action: :insert,
                 changes: %{name: "ACME"},
                 errors: [],
                 data: %Company{},
                 valid?: true
               },
               lastname: "Doe",
               name: "John"
             },
             errors: [],
             data: %User{},
             valid?: true
           } =
             Caster.cast(%User{}, %{name: "John", lastname: "Doe", company: %{name: "ACME"}},
               with: {__MODULE__, :get_changeset, [:strict]}
             )
  end

  test "new" do
    assert %User{} = Caster.new(%User{}, %{name: "John", lastname: "Doe"})
    assert %User{} = Caster.new(User, %{name: "John", lastname: "Doe"})
  end

  test "validate" do
    assert %Ecto.Changeset{valid?: false} =
             ch =
             Caster.validate(User, %{}, fn ch ->
               ch
               |> Ecto.Changeset.validate_required([:name])
             end)

    assert %User{} = ch.data
    IO.inspect(ch)
  end
end
