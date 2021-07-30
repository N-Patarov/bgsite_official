defmodule BgsiteOfficial.PromotionsTest do
  use BgsiteOfficial.DataCase

  alias BgsiteOfficial.Promotions

  describe "promotions" do
    alias BgsiteOfficial.Promotions.Promotion

    @valid_attrs %{email: "some email", name: "some name", text: "some text", url: "some url"}
    @update_attrs %{email: "some updated email", name: "some updated name", text: "some updated text", url: "some updated url"}
    @invalid_attrs %{email: nil, name: nil, text: nil, url: nil}

    def promotion_fixture(attrs \\ %{}) do
      {:ok, promotion} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Promotions.create_promotion()

      promotion
    end

    test "list_promotions/0 returns all promotions" do
      promotion = promotion_fixture()
      assert Promotions.list_promotions() == [promotion]
    end

    test "get_promotion!/1 returns the promotion with given id" do
      promotion = promotion_fixture()
      assert Promotions.get_promotion!(promotion.id) == promotion
    end

    test "create_promotion/1 with valid data creates a promotion" do
      assert {:ok, %Promotion{} = promotion} = Promotions.create_promotion(@valid_attrs)
      assert promotion.email == "some email"
      assert promotion.name == "some name"
      assert promotion.text == "some text"
      assert promotion.url == "some url"
    end

    test "create_promotion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Promotions.create_promotion(@invalid_attrs)
    end

    test "update_promotion/2 with valid data updates the promotion" do
      promotion = promotion_fixture()
      assert {:ok, %Promotion{} = promotion} = Promotions.update_promotion(promotion, @update_attrs)
      assert promotion.email == "some updated email"
      assert promotion.name == "some updated name"
      assert promotion.text == "some updated text"
      assert promotion.url == "some updated url"
    end

    test "update_promotion/2 with invalid data returns error changeset" do
      promotion = promotion_fixture()
      assert {:error, %Ecto.Changeset{}} = Promotions.update_promotion(promotion, @invalid_attrs)
      assert promotion == Promotions.get_promotion!(promotion.id)
    end

    test "delete_promotion/1 deletes the promotion" do
      promotion = promotion_fixture()
      assert {:ok, %Promotion{}} = Promotions.delete_promotion(promotion)
      assert_raise Ecto.NoResultsError, fn -> Promotions.get_promotion!(promotion.id) end
    end

    test "change_promotion/1 returns a promotion changeset" do
      promotion = promotion_fixture()
      assert %Ecto.Changeset{} = Promotions.change_promotion(promotion)
    end
  end
end
