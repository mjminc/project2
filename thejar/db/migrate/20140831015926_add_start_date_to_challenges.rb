class AddStartDateToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :start_date, :datetime
  end
end
