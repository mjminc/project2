class DropStartDateFromChallenges < ActiveRecord::Migration
  def change
    remove_column :challenges, :start_date
  end
end
