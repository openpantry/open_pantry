defmodule OpenPantry.SharedRepo do
  defmacro __using__(_) do
    quote do
      alias OpenPantry.Repo
      alias __MODULE__

      @type t :: %__MODULE__{}

      @spec find(integer()) :: __MODULE__.t | nil
      def find(id) when is_integer(id), do:  query(id) |> Repo.one!

      @spec find(integer(), list(atom())) :: __MODULE__.t | nil
      def find(id, preload) when is_integer(id) and is_list(preload) do
        query(id, preload) |> Repo.one!
      end

      @spec all() :: list(__MODULE__.t) | []
      def all() do
        all([])
      end

      @spec all(list(atom())) :: list(__MODULE__.t) | []
      def all(preload) when is_list(preload) do
        query_all(preload) |> Repo.all
      end

      @spec query_all() :: Ecto.Query.t
      def query_all() do
        query_all([])
      end

      @spec query_all(list(atom())) :: Ecto.Query.t
      def query_all(preload) when is_list(preload) do
        from(_struct in __MODULE__,
        preload: ^preload)
      end

      @spec query(integer()) :: Ecto.Query.t
      def query(id) when is_integer(id) do
        from(struct in __MODULE__,
        where: struct.id == ^id)
      end
      @spec query(integer(), list(atom())) :: Ecto.Query.t
      def query(id, preload) when is_integer(id) and is_list(preload) do
        from(struct in __MODULE__,
        where: struct.id == ^id,
        preload: ^preload)
      end
      defoverridable [query: 1, query: 2, find: 1, find: 2, query_all: 0, query_all: 1, all: 0, all: 1]
    end
  end

end