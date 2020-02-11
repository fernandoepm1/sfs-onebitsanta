class AddStatusToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :status, :integer, default: 0
  end
end
