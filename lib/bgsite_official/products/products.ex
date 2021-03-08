defmodule BgsiteOfficial.Products do

  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias BgsiteOfficial.Repo
  alias BgsiteOfficial.Products.Product
  alias BgsiteOfficial.Products.Variant

  def list_products do
    Repo.all(Product)
  end

  def paginate_products(params \\ []) do
    Product
    |> Repo.paginate(params)
  end


  def get_product!(id), do: Repo.get!(Product, id) |> Repo.preload(variants: from(v in Variant, order_by: v.id))


  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.
  ## Examples
      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}
      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Product.
  ## Examples
      iex> delete_product(product)
      {:ok, %Product{}}
      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}
  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.
  ## Examples
      iex> change_product(product)
      %Ecto.Changeset{source: %Product{}}
  """
  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end

  @doc """
  Returns the list of variants for a product.
  ## Examples
      iex> list_variants(product)
      [%Variant{}, ...]
  """

  def list_variants(product) do
    from(v in Variant, where: [product_id: ^product.id], order_by: [asc: :id])
    |> Repo.all()
  end

  @doc """
  Gets a single variant.

  Raises `Ecto.NoResultsError` if the Variant does not exist.

  ## Examples

      iex> get_variant!(123)
      %Variant{}

      iex> get_variant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_variant!(product, id), do: Repo.get_by!(Variant, product_id: product.id, id: id)

  @doc """
  Creates a variant.

  ## Examples

      iex> create_variant(%{field: value})
      {:ok, %Variant{}}

      iex> create_variant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_variant(attrs \\ %{}) do
    product
    |> Ecto.build_assoc(:variants)
    |> Variant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a variant.

  ## Examples

      iex> update_variant(variant, %{field: new_value})
      {:ok, %Variant{}}

      iex> update_variant(variant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_variant(%Variant{} = variant, attrs) do
    variant
    |> Variant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a variant.

  ## Examples

      iex> delete_variant(variant)
      {:ok, %Variant{}}

      iex> delete_variant(variant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_variant(%Variant{} = variant) do
    Repo.delete(variant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking variant changes.

  ## Examples

      iex> change_variant(variant)
      %Ecto.Changeset{data: %Variant{}}

  """
  def change_variant(%Variant{} = variant, attrs \\ %{}) do
    Variant.changeset(variant, attrs)
  end
end
