class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string  :name
      t.string  :email
      t.boolean :mail_opened, default: false
      t.boolean :is_user, default: false
      t.string  :token

      t.timestamps
    end
  end
end
