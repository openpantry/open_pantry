defmodule OpenPantry.SharedRepo do
  defmacro __using__([]) do

    quote do
      @spec all(module()) :: list(%{})
      def all(module) do
        module |> Repo.all
      end

      @spec find(module(), integer()) :: %{}
      def find(module, id) when is_integer(id), do:  query(module, id) |> Repo.one!

      @spec find(module(), integer(), list()) :: %{}
      def find(module, id, preload) when is_integer(id) do
        query(module, id, preload) |> Repo.one!
      end

      @spec query(module(), integer()) :: %{}
      def query(module, id) when is_integer(id) do
        from(struct in module,
        where: struct.id == ^id)
      end
      @spec query(module(), integer(), list()) :: %{}
      def query(module, id, preload) when is_integer(id) do
        from(struct in module,
        where: struct.id == ^id,
        preload: ^preload)
      end

      defoverridable [query: 2, find: 2]
    end

  end



end