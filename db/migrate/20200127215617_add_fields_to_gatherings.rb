class AddFieldsToGatherings < ActiveRecord::Migration[5.2]
  def change
    add_column :gatherings, :event_date, :datetime
    add_column :gatherings, :event_hour, :string
  end
end
