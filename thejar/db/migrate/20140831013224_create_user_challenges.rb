class CreateUserChallenges < ActiveRecord::Migration
  def change
    create_table :user_challenges do |t|
      t.string :role
      t.boolean :is_accepted
      t.integer :balance
      t.boolean :challenge_success
      t.text :video_url
      t.references :user
      t.references :challenge
      t.timestamps
    end
  end
end
