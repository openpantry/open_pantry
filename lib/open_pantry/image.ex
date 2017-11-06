defmodule OpenPantry.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]
  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  def acl(:thumb, _), do: :public_read

  @doc """
  Validate an image file.
  Currently only validates the extension,
  checking that it is in a whitelist,
  currently [#{@extension_whitelist |> Enum.join(", ")}].

  ## Examples:

  iex> OpenPantry.Image.validate { %{ file_name: "foo.jpg" }, :_ }
  true

  iex> OpenPantry.Image.validate { %{ file_name: "foo.txt" }, :_ }
  false

  """
  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname |> String.downcase
    Enum.member?(@extension_whitelist, file_extension)
  end

  def transform(:thumb, _) do
    {:convert, "-thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  end

  def filename(version, _) do
    version
  end

  def storage_dir(_, {_file, stock = %{image: _image, id: id}}) when not is_nil(id) do
    "uploads/images/#{stock.id}"
  end

  def default_url(:thumb) do
    "https://placehold.it/100x100"
  end

  if Mix.env == :dev do
    def __storage, do: Arc.Storage.Local
  end

end
