logger = Logger.new($stdout)

ActiveRecord::Base.transaction do
  YAML.load_file(Rails.root.join('db/yaml/departures.yml'))&.each do |departure|
    new_departure = Departure.find_or_create_by!(date: Date.strptime(departure['date'],'%d/%m/%Y'), price: departure['price'])
    logger.info("Departure created - date: #{new_departure.date}, price: #{new_departure.price}")
  end
rescue ActiveRecord::RecordInvalid, Errno::ENOENT => e
  logger.error("Sorry your transaction failed. Reason: #{e}")
end


logger.info("Created Departure: #{Departure.count}")
