defmodule BgsiteOfficial.Home.Websites do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias FileUploader.Home.Websites

  schema "websites" do
    field :banner, :string
    field :description, :string
    field :likes, :integer
    field :title, :string

    timestamps()
  end

  @doc false


  def changeset(websites, attrs) do
    websites
    |> cast(attrs, [:title, :banner, :description, :likes])
    |> cast_attachments(attrs, [:banner])
    |> validate_required([:title, :banner, :description, :likes])
  end

  defp add_timestamp(%{"banner" => %Plug.Upload{filename: name} = banner} = attrs) do
    banner = %Plug.Upload{banner | filename: prepend_timestamp(name)}
    %{attrs | "banner" => banner}
  end

  defp add_timestamp(params), do: params

  defp prepend_timestamp(name) do
    "#{:os.system_time()}" <> name
  end
end
