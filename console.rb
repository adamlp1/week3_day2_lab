require('pry-byebug')
require_relative('./models/property.rb')

Property.delete_all


property1 = Property.new({
  'address' => '10 Downing Street',
  'value' => 10,
  'num_of_rooms' => 5,
  'year_built' => 1875
})

property2 = Property.new({
  'address' => '4 Privet Drive',
  'value' => 100,
  'num_of_rooms' => 3,
  'year_built' => 1976

})

buildings = Property.all()

property1.save()

binding.pry

nil
