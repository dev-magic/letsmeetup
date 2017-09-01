# A potential time for an event
class Timeslot < ApplicationRecord
  belongs_to :event
  has_many :preferences, through: :event
end
