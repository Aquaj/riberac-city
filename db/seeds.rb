require 'yaml'

print '> Destroying database...'
Option.destroy_all
Category.destroy_all
User.destroy_all
puts '> Done!'

puts '=' * 20

puts '> loading YAML files'
users_data = YAML.load(File.read('db/seed_data/users.yml'))
categories_data = YAML.load(File.read('db/seed_data/categories.yml'))
options_data = YAML.load(File.read('db/seed_data/options.yml'))
puts '> Done!'


puts '=' * 20

puts '> Seeding Users'
users_data.each do |user|
  new_user = User.create!(user)
  puts "> Seeded #{new_user.first_name.capitalize} #{new_user.last_name.capitalize}"
end
puts 'Done!'

puts '=' * 20

puts '> Seeding Categories...'
categories_data.each do |category|
  new_category = Category.create!(name: category)

  puts '-' * 20
  puts ">>> seeding #{new_category.name}'s options"
  options_data[category].each do |option|
    new_option = Option.create!(name: option, category: new_category)
    puts ">>> seeded #{new_option.name}'s options"
  end
  puts '-' * 20

  puts ">> Seeded #{new_category.name}"
end
puts 'Done!'

puts '=' * 20

puts '> Seeding places'
places_data = YAML.load(ERB.new(File.read('db/seed_data/places.yml')).result)
places_pictures = YAML.load(File.read('db/seed_data/places_pictures.yml'))
places_option_data = YAML.load(File.read('db/seed_data/places_options.yml'))
counter = 0
places_data.each do |place|
  new_place = Place.new(place)
  new_place.user = User.find_by(first_name: 'Jean-Paul')
  picture = places_pictures[counter]
  new_place.picture_urls = [picture]
  new_place.save
  counter +=1
  puts '>>> Seeding places options'
  places_option_data[new_place.title].each do |place_option|
    option = Option.find_by(name: place_option)
    new_place_option = PlaceOption.create!(place: new_place, option: option)
    puts ">>> Seeded #{new_place_option.option.name}"
  end
  puts '-' * 20
  puts '>>> Done!'
  puts "> Seeded #{new_place.title}"
end
puts '> Done!'
