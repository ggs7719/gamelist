class Event < ActiveRecord::Base
  has_many :attendees, :dependent => :destroy
  validates_presence_of :name
  belongs_to :category
  has_many :event_groupships
  has_many :groups, :through => :event_groupships
end