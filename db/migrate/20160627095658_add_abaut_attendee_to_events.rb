class AddAbautAttendeeToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :attendee_count, :integer, default: 0
    add_column :events, :attendee_update, :datetime
  end
end
