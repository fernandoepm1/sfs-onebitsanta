class AddFieldsToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :event_date, :datetime
    add_column :parties, :event_hour, :string
  end
end
