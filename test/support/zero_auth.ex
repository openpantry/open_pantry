defmodule OpenPantry.ZeroAuth do
  def init(opts), do: opts
  def call(conn, _opts), do: conn
end