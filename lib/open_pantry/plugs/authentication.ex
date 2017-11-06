defmodule OpenPantry.Plugs.Authentication do
  @authentication Application.get_env(:open_pantry, :admin_authentication)
  def init(opts) do
    @authentication.init(opts)
  end
  def call(conn, opts) do
    @authentication.call(conn, opts)
  end
end
