class ChangeChallengeAmountToIntOnChallenges < ActiveRecord::Migration
  def change
    change_column :challenges, :challenge_amount, 'integer USING CAST(challenge_amount AS integer)'
  end
end
