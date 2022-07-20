require 'test_helper'

class AssignPreAndPostAccommodationTest < ActiveSupport::TestCase
  setup do
    Rails.application.load_tasks
    @departure = Departure.find_or_create_by!(date: Date.new(2033,1,1), price: 10)
    @accommodations_start_count = YAML.load_file(Rails.root.join('db/yaml/accommodations_start.yml')).count
    @accommodations_end_count = YAML.load_file(Rails.root.join('db/yaml/accommodations_end.yml')).count
    Rake.application.invoke_task "developer:assign_pre_and_post_accommodation"
  end

  test "assign accommodations_start and @accommodations_end" do
    assert_equal @accommodations_start_count, @departure.accommodation_start.count
    assert_equal @accommodations_end_count, @departure.accommodation_end.count
  end
end
