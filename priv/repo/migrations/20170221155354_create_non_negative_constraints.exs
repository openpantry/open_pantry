defmodule OpenPantry.Repo.Migrations.CreateUnonNegativeConstraints do
  use Ecto.Migration

  def change do
    create constraint(:stocks,              "non_negative_quantity", check: "quantity >= 0", comment: "Non negative quantity")
    create constraint(:stock_distributions, "non_negative_quantity", check: "quantity >= 0", comment: "Non negative quantity")
    create constraint(:user_credits,        "non_negative_balance",  check: "balance >= 0",  comment: "Non negative balance")
  end
end
