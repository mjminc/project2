class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title
      t.string :start_date
      t.string :category
      t.string :challenge_amount
      t.string :charity_id
      t.string :status

      t.timestamps
    end
  end
end
