# Haka Exercise App

Exercise is just Implementation of a rake task, so assume testing,lint, rubocop are out of scope.\
This project is made by `rails new haka`using below packages 
```
rails 7.0.3
ruby 3.0.0
sqlite3
```

## How to execute

### Setup
```bash
bundle install # install bundle

rails db:migrate # generate two tables: departures, accommodations
rails db:seed # Import 7 departures from db/yaml/departures.yml before executing assign_pre_and_post_accommodation
```

### Rake take
Departure has 4 fields(date, price, accommodation_start, accommodation_end)\
Departure has many relations with Accommodation via accommodation_start, accommodation_end
```bash
rake developer:assign_pre_and_post_accommodation
```
The rake is `lib/tasks/developer.rake`
This rake task assigns accommodation start and accommodation end to departures from 'db/yaml/accommodations_start.yml' and 'db/yaml/accommodations_end.yml'

### Model
To just execute the rake task, `Accommodation` and `Departure` are made.