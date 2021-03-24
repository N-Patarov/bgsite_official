defmodule BgsiteOfficial.ContactsTest do
  use BgsiteOfficial.DataCase

  alias BgsiteOfficial.Contacts

  describe "feedback" do
    alias BgsiteOfficial.Contacts.Feedback

    @valid_attrs %{email: "some email", name: "some name", text: "some text"}
    @update_attrs %{email: "some updated email", name: "some updated name", text: "some updated text"}
    @invalid_attrs %{email: nil, name: nil, text: nil}

    def feedback_fixture(attrs \\ %{}) do
      {:ok, feedback} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Contacts.create_feedback()

      feedback
    end

    test "list_feedback/0 returns all feedback" do
      feedback = feedback_fixture()
      assert Contacts.list_feedback() == [feedback]
    end

    test "get_feedback!/1 returns the feedback with given id" do
      feedback = feedback_fixture()
      assert Contacts.get_feedback!(feedback.id) == feedback
    end

    test "create_feedback/1 with valid data creates a feedback" do
      assert {:ok, %Feedback{} = feedback} = Contacts.create_feedback(@valid_attrs)
      assert feedback.email == "some email"
      assert feedback.name == "some name"
      assert feedback.text == "some text"
    end

    test "create_feedback/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contacts.create_feedback(@invalid_attrs)
    end

    test "update_feedback/2 with valid data updates the feedback" do
      feedback = feedback_fixture()
      assert {:ok, %Feedback{} = feedback} = Contacts.update_feedback(feedback, @update_attrs)
      assert feedback.email == "some updated email"
      assert feedback.name == "some updated name"
      assert feedback.text == "some updated text"
    end

    test "update_feedback/2 with invalid data returns error changeset" do
      feedback = feedback_fixture()
      assert {:error, %Ecto.Changeset{}} = Contacts.update_feedback(feedback, @invalid_attrs)
      assert feedback == Contacts.get_feedback!(feedback.id)
    end

    test "delete_feedback/1 deletes the feedback" do
      feedback = feedback_fixture()
      assert {:ok, %Feedback{}} = Contacts.delete_feedback(feedback)
      assert_raise Ecto.NoResultsError, fn -> Contacts.get_feedback!(feedback.id) end
    end

    test "change_feedback/1 returns a feedback changeset" do
      feedback = feedback_fixture()
      assert %Ecto.Changeset{} = Contacts.change_feedback(feedback)
    end
  end
end
