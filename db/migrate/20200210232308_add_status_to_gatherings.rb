class AddStatusToGatherings < ActiveRecord::Migration[5.2]
  def change
    add_column :gatherings, :status, :integer, default: 0
  end
end
