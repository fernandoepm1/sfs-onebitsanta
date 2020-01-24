class CreateGatheringMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :gathering_members do |t|
      t.references :gathering, foreign_key: true
      t.references :member,    foreign_key: true

      t.timestamps
    end
  end
end
