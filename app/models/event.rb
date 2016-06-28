class Event < ActiveRecord::Base

  belongs_to :user
  has_many :attendees, :dependent => :destroy
  validates_presence_of :name
  belongs_to :category
  has_many :event_groupships
  has_many :groups, :through => :event_groupships

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
end
