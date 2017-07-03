defmodule Mix.Tasks.Cron.UpdateCredits do
  use Mix.Task

  @shortdoc "Refreshes all credits for all users in the system"
  def run(_) do
    {:ok, _started} = Application.ensure_all_started(:open_pantry)
    OpenPantry.UpdateCredits.all()
  end
end