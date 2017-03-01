defmodule OpenPantry.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use OpenPantry.Web, :controller
      use OpenPantry.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema
      alias __MODULE__
      alias OpenPantry.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      @type t :: %__MODULE__{}

      @spec all() :: list(%{})
      def all do
        __MODULE__ |> Repo.all
      end

      @spec find(integer()) :: %{}
      def find(id) when is_integer(id), do:  query(id) |> Repo.one!

      @spec find(integer(), list()) :: %{}
      def find(id, preload) when is_integer(id) do
        query(id, preload) |> Repo.one!
      end

      @spec query(integer()) :: %{}
      def query(id) when is_integer(id) do
        from(struct in __MODULE__,
        where: struct.id == ^id)
      end
      @spec query(integer(), list()) :: %{}
      def query(id, preload) when is_integer(id) do
        from(struct in __MODULE__,
        where: struct.id == ^id,
        preload: ^preload)
      end

      defoverridable [query: 1, query: 2, find: 1, find: 2, all: 0]

    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias OpenPantry.Repo
      import Ecto
      import Ecto.Query

      import OpenPantry.Router.Helpers
      import OpenPantry.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import OpenPantry.Router.Helpers
      import OpenPantry.ErrorHelpers
      import OpenPantry.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias OpenPantry.Repo
      import Ecto
      import Ecto.Query
      import OpenPantry.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
