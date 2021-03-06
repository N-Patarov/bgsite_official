defmodule BgsiteOfficial.HomeTest do
  use BgsiteOfficial.DataCase

  alias BgsiteOfficial.Home

  describe "pictures" do
    alias FileUploader.Storage.Picture

    @valid_attrs %{title: "some title", image: %Plug.Upload{path: "test/fixtures/image.png", filename: "image.png"}}
    @update_attrs %{title: "some updated title", image: %Plug.Upload{path: "test/fixtures/image.png", filename: "image.png"}}

  end  


  describe "websites" do
    alias BgsiteOfficial.Home.Websites

    @valid_attrs %{banner: "some banner", description: "some description", likes: 42, title: "some title"}
    @update_attrs %{banner: "some updated banner", description: "some updated description", likes: 43, title: "some updated title"}
    @invalid_attrs %{banner: nil, description: nil, likes: nil, title: nil}

    def websites_fixture(attrs \\ %{}) do
      {:ok, websites} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Home.create_websites()

      websites
    end

    test "list_websites/0 returns all websites" do
      websites = websites_fixture()
      assert Home.list_websites() == [websites]
    end

    test "get_websites!/1 returns the websites with given id" do
      websites = websites_fixture()
      assert Home.get_websites!(websites.id) == websites
    end

    test "create_websites/1 with valid data creates a websites" do
      assert {:ok, %Websites{} = websites} = Home.create_websites(@valid_attrs)
      assert websites.banner == "some banner"
      assert websites.description == "some description"
      assert websites.likes == 42
      assert websites.title == "some title"
    end

    test "create_websites/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Home.create_websites(@invalid_attrs)
    end

    test "update_websites/2 with valid data updates the websites" do
      websites = websites_fixture()
      assert {:ok, %Websites{} = websites} = Home.update_websites(websites, @update_attrs)
      assert websites.banner == "some updated banner"
      assert websites.description == "some updated description"
      assert websites.likes == 43
      assert websites.title == "some updated title"
    end

    test "update_websites/2 with invalid data returns error changeset" do
      websites = websites_fixture()
      assert {:error, %Ecto.Changeset{}} = Home.update_websites(websites, @invalid_attrs)
      assert websites == Home.get_websites!(websites.id)
    end

    test "delete_websites/1 deletes the websites" do
      websites = websites_fixture()
      assert {:ok, %Websites{}} = Home.delete_websites(websites)
      assert_raise Ecto.NoResultsError, fn -> Home.get_websites!(websites.id) end
    end

    test "change_websites/1 returns a websites changeset" do
      websites = websites_fixture()
      assert %Ecto.Changeset{} = Home.change_websites(websites)
    end
  end
end
