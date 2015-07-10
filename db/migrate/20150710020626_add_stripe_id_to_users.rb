class AddStripeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :stripe_subscription, :string
  end
end
