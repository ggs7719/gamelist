class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id, :index => true
      t.integer :event_id, :index => true
      t.integer :attendee_id, :index => true

      t.timestamps null: false
    end
  end
end
