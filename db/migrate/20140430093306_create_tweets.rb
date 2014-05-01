class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.point :location, :srid => 4326, :null => false
      t.text :body, :null => false
      t.datetime :interval, :null => false

      t.timestamps
    end
  end
end
