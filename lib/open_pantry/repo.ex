defmodule OpenPantry.Repo do
  use Ecto.Repo, otp_app: :open_pantry
  use Scrivener, page_size: 10
end
