class Event < ActiveRecord::Base

  has_many :subscriptions
  has_many :subscribed_users, :source => :user
  belongs_to :user
  has_many :attendees, :dependent => :destroy
  validates_presence_of :name
  belongs_to :category
  has_many :event_groupships
  has_many :groups, :through => :event_groupships

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  def finy_subscription_by(user)
    user && self.subscriptions.find_by_user_id( user.id )
  end

end
