defmodule OpenPantry.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]
  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  def acl(:thumb, _), do: :public_read

  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname |> String.downcase
    Enum.member?(@extension_whitelist, file_extension)
  end

  def transform(:thumb, _) do
    {:convert, "-thumbnail 100x100^ -gravity center -extent 100x100 -format png", :png}
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