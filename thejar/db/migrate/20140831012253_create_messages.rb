class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.boolean :is_private
      t.boolean :is_caught
      t.boolean :is_confirmed
      t.text :img_url
      t.boolean :is_invitation
      t.references :user
      t.references :challenge
      t.timestamps
    end
  end
end
