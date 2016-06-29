class Attendee < ActiveRecord::Base
	belongs_to :event
	has_many :likes

  def finy_like_by(user)
    user && self.likes.find_by_user_id( user.id )
  end
end
