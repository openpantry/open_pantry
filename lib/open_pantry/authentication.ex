defmodule OpenPantry.Authentication do
  @authentication Application.get_env(:open_pantry, :authentication)
  def init(opts) do
    @authentication.init(opts)
  end
  def call(conn, opts) do
    @authentication.call(conn, opts)
  end
end