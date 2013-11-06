class AlterEvents < ActiveRecord::Migration
  def up
    add_column :events, :university_id, :integer
    Event.all.each do |event|
      if event.eventable_type=="Club"
        club = Club.find event.eventable_id
        event.update_attributes(club_id: club.id, university_id: club.university_id)
      else
        event.update_attributes(university_id: event.eventable_id)
      end
    end
  end

  def down
  end
end
