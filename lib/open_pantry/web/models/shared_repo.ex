defmodule OpenPantry.SharedRepo do
  defmacro __using__(_) do
    quote do
      alias OpenPantry.Repo
      alias __MODULE__

      @type t :: %__MODULE__{}

      @spec all() :: list(__MODULE__.t)
      def all do
        __MODULE__ |> Repo.all
      end

      @spec find(integer()) :: __MODULE__.t | nil
      def find(id) when is_integer(id), do:  query(id) |> Repo.one!

      @spec find(integer(), list(atom())) :: __MODULE__.t | nil
      def find(id, preload) when is_integer(id) do
        query(id, preload) |> Repo.one!
      end

      @spec query(integer()) :: Ecto.Query.t
      def query(id) when is_integer(id) do
        from(struct in __MODULE__,
        where: struct.id == ^id)
      end
      @spec query(integer(), list(atom())) :: Ecto.Query.t
      def query(id, preload) when is_integer(id) do
        from(struct in __MODULE__,
        where: struct.id == ^id,
        preload: ^preload)
      end
      defoverridable [query: 1, query: 2, find: 1, find: 2, all: 0]
    end
  end

end