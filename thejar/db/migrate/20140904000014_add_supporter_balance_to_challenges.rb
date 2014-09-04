class AddSupporterBalanceToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :supporter_amount, :integer
  end
end
