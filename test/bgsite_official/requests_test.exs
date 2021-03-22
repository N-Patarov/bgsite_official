defmodule BgsiteOfficial.RequestsTest do
  use BgsiteOfficial.DataCase

  alias BgsiteOfficial.Requests

  describe "requests" do
    alias BgsiteOfficial.Requests.Request

    @valid_attrs %{description: "some description", email: "some email", name: "some name", url: "some url"}
    @update_attrs %{description: "some updated description", email: "some updated email", name: "some updated name", url: "some updated url"}
    @invalid_attrs %{description: nil, email: nil, name: nil, url: nil}

    def request_fixture(attrs \\ %{}) do
      {:ok, request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Requests.create_request()

      request
    end

    test "list_requests/0 returns all requests" do
      request = request_fixture()
      assert Requests.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id" do
      request = request_fixture()
      assert Requests.get_request!(request.id) == request
    end

    test "create_request/1 with valid data creates a request" do
      assert {:ok, %Request{} = request} = Requests.create_request(@valid_attrs)
      assert request.description == "some description"
      assert request.email == "some email"
      assert request.name == "some name"
      assert request.url == "some url"
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Requests.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request" do
      request = request_fixture()
      assert {:ok, %Request{} = request} = Requests.update_request(request, @update_attrs)
      assert request.description == "some updated description"
      assert request.email == "some updated email"
      assert request.name == "some updated name"
      assert request.url == "some updated url"
    end

    test "update_request/2 with invalid data returns error changeset" do
      request = request_fixture()
      assert {:error, %Ecto.Changeset{}} = Requests.update_request(request, @invalid_attrs)
      assert request == Requests.get_request!(request.id)
    end

    test "delete_request/1 deletes the request" do
      request = request_fixture()
      assert {:ok, %Request{}} = Requests.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> Requests.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset" do
      request = request_fixture()
      assert %Ecto.Changeset{} = Requests.change_request(request)
    end
  end
end
