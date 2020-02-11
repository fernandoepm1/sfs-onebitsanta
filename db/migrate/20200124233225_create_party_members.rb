class CreatePartyMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :party_members do |t|
      t.references :party,  foreign_key: true
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
