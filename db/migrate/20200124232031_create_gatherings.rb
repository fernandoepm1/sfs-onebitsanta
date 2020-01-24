class CreateGatherings < ActiveRecord::Migration[5.2]
  def change
    create_table :gatherings do |t|
      t.string     :title
      t.text       :description
      t.references :user, foreign_key: true
      t.decimal    :gift_value
      t.text       :location

      t.timestamps
    end
  end
end
