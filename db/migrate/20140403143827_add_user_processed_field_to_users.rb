class AddUserProcessedFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_id, :string, default: ""
  end
end
