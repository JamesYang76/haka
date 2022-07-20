class Departure < ApplicationRecord
  has_many :accommodation_start, class_name: "Accommodation", foreign_key: :start_id, dependent: :destroy
  has_many :accommodation_end, class_name: "Accommodation",  foreign_key: :end_id, dependent: :destroy
end
