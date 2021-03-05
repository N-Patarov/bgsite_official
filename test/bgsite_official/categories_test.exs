defmodule BgsiteOfficial.CategoriesTest do
  use BgsiteOfficial.DataCase

  alias BgsiteOfficial.Categories

  describe "tags" do
    alias BgsiteOfficial.Categories.Tag

    @valid_attrs %{banner: "some banner", description: "some description", likes: 42, title: "some title"}
    @update_attrs %{banner: "some updated banner", description: "some updated description", likes: 43, title: "some updated title"}
    @invalid_attrs %{banner: nil, description: nil, likes: nil, title: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Categories.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Categories.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Categories.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Categories.create_tag(@valid_attrs)
      assert tag.banner == "some banner"
      assert tag.description == "some description"
      assert tag.likes == 42
      assert tag.title == "some title"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Categories.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Categories.update_tag(tag, @update_attrs)
      assert tag.banner == "some updated banner"
      assert tag.description == "some updated description"
      assert tag.likes == 43
      assert tag.title == "some updated title"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Categories.update_tag(tag, @invalid_attrs)
      assert tag == Categories.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Categories.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Categories.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Categories.change_tag(tag)
    end
  end
end
