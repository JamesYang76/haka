namespace :developer do
  desc "Handling data in Departure and Accommodation"

  class Error < StandardError; end

  task :assigned_logger do
    @logger = Logger.new($stdout)
  end

  task assign_pre_and_post_accommodation: :environment do
    departures = Departure.where(date: Date.new(2022,1,1)..)

    accommodations_start = YAML.load_file(Rails.root.join('db/yaml/accommodations_start.yml'))
    accommodations_end = YAML.load_file(Rails.root.join('db/yaml/accommodations_end.yml'))
    ActiveRecord::Base.transaction do
      departures.each do |departure|
        @logger.info("========================================================")
        @logger.info("Departure date: #{departure.date}, price: #{departure.price}")
        assign_accommodations_start(departure: departure, accommodations_start: accommodations_start)
        assign_accommodations_end(departure: departure, accommodations_end: accommodations_end)
        @logger.info("\n")
      end
    end

    display_results(departures: departures,accommodations_start: accommodations_start, accommodations_end: accommodations_end)
  rescue ActiveRecord::RecordInvalid, Errno::ENOENT, Error => e
    @logger.error("Sorry your transaction failed. Reason: #{e}")
  end

  def assign_accommodations_start(departure:, accommodations_start:)
    @logger.info("-------------- accommodations_start ---------------------")
    accommodations_start.each_with_index do |start_data, idx|
      validating_accommodation(item: start_data, type: "start", line: idx + 1)
      a_start = accommodations_create!(accommodations: departure.accommodation_start, item: start_data)
      @logger.info("Accommodation Start Added name: #{a_start.name}, location: #{a_start.location}")
    end
  end

  def assign_accommodations_end(departure:, accommodations_end:)
    @logger.info("-------------- accommodations_end ---------------------")
    accommodations_end.each_with_index do |end_data, idx|
      validating_accommodation(item: end_data, type: "end", line: idx + 1)
      a_end = accommodations_create!(accommodations: departure.accommodation_end, item: end_data)
      @logger.info("Accommodation End Added name: #{a_end.name}, location: #{a_end.location}")
    end
  end

  def accommodations_create!(accommodations:, item:)
    accommodations.find_or_create_by!(
      name: item['name'],
      location: item['location'],
      price: item['price']
      )
  end

  def validating_accommodation(item:, type:, line:)
    raise Error, "accommodation_#{type} item: #{line} Invalid" unless item['name'].present? && item['location'].present? && item['price'].present?
  end

  def display_results(departures:, accommodations_start:, accommodations_end:)
    @logger.info("Per #{departures.count} departures")
    @logger.info("#{accommodations_start.count} accommodations_start, #{accommodations_end.count} accommodations_end")
    @logger.info("Updated!!!")
  end
end

Rake::Task['developer:assign_pre_and_post_accommodation'].enhance ['developer:assigned_logger']