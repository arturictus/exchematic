defmodule Schematic.Caster do
  def cast(%schema{} = struct, params) do
    embed_names = schema.__schema__(:embeds)
    field_names = schema.__schema__(:fields)
    ch = Ecto.Changeset.cast(struct, params, field_names -- embed_names)

    Enum.reduce(embed_names, ch, fn embed_name, ch ->
      Ecto.Changeset.cast_embed(ch, embed_name, with: &cast/2)
    end)
  end

  def cast(%schema{} = struct, params, options) do
    embed_names = schema.__schema__(:embeds)
    field_names = schema.__schema__(:fields)
    ch = Ecto.Changeset.cast(struct, params, field_names -- embed_names)

    Enum.reduce(embed_names, ch, fn embed_name, ch ->
      Ecto.Changeset.cast_embed(ch, embed_name, options)
    end)
  end

  def cast(module, params) do
    struct!(module)
    |> cast(params)
  end

  def new(%Ecto.Changeset{} = ch) do
    ch
    |> Ecto.Changeset.apply_action!(:insert)
  end

  def new(%Ecto.Changeset{} = ch, _params) do
    ch
    |> Ecto.Changeset.apply_action!(:insert)
  end

  def new(module, params) do
    cast(module, params)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  def validate(module, params, fun) do
    cast(module, params)
    |> fun.()
  end
end
