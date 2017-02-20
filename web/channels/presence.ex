defmodule OpenPantry.Presence do
  use Phoenix.Presence, otp_app: :my_app,
                        pubsub_server: OpenPantry.PubSub


end