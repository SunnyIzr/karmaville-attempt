class AddScoreIndexToUser < ActiveRecord::Migration
  def change
    add_index :users, :score
  end
end
