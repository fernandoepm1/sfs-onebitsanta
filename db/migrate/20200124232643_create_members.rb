class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string  :name
      t.string  :email
      t.boolean :saw_mail
      t.boolean :is_user
      t.string  :token

      t.timestamps
    end
  end
end