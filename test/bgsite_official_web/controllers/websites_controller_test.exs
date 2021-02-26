defmodule BgsiteOfficialWeb.WebsitesControllerTest do
  use BgsiteOfficialWeb.ConnCase

  alias BgsiteOfficial.Home

  @create_attrs %{banner: "some banner", description: "some description", likes: 42, title: "some title"}
  @update_attrs %{banner: "some updated banner", description: "some updated description", likes: 43, title: "some updated title"}
  @invalid_attrs %{banner: nil, description: nil, likes: nil, title: nil}

  def fixture(:websites) do
    {:ok, websites} = Home.create_websites(@create_attrs)
    websites
  end

  describe "index" do
    test "lists all websites", %{conn: conn} do
      conn = get(conn, Routes.websites_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Websites"
    end
  end

  describe "new websites" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.websites_path(conn, :new))
      assert html_response(conn, 200) =~ "New Websites"
    end
  end

  describe "create websites" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.websites_path(conn, :create), websites: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.websites_path(conn, :show, id)

      conn = get(conn, Routes.websites_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Websites"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.websites_path(conn, :create), websites: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Websites"
    end
  end

  describe "edit websites" do
    setup [:create_websites]

    test "renders form for editing chosen websites", %{conn: conn, websites: websites} do
      conn = get(conn, Routes.websites_path(conn, :edit, websites))
      assert html_response(conn, 200) =~ "Edit Websites"
    end
  end

  describe "update websites" do
    setup [:create_websites]

    test "redirects when data is valid", %{conn: conn, websites: websites} do
      conn = put(conn, Routes.websites_path(conn, :update, websites), websites: @update_attrs)
      assert redirected_to(conn) == Routes.websites_path(conn, :show, websites)

      conn = get(conn, Routes.websites_path(conn, :show, websites))
      assert html_response(conn, 200) =~ "some updated banner"
    end

    test "renders errors when data is invalid", %{conn: conn, websites: websites} do
      conn = put(conn, Routes.websites_path(conn, :update, websites), websites: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Websites"
    end
  end

  describe "delete websites" do
    setup [:create_websites]

    test "deletes chosen websites", %{conn: conn, websites: websites} do
      conn = delete(conn, Routes.websites_path(conn, :delete, websites))
      assert redirected_to(conn) == Routes.websites_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.websites_path(conn, :show, websites))
      end
    end
  end

  defp create_websites(_) do
    websites = fixture(:websites)
    %{websites: websites}
  end
end
