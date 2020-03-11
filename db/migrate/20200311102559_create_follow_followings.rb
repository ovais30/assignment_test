class CreateFollowFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_followings do |t|
      t.integer :follower_id
      t.integer :following_id
      t.boolean :status

      t.timestamps
    end
  end
end
