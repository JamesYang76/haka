class Accommodation < ApplicationRecord
  belongs_to :start, class_name: 'Departure', optional: true
  belongs_to :end, class_name: 'Departure', optional: true
end
