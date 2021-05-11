require_relative 'patient'
require_relative 'room'

sally = Patient.new(name: 'sally', age: 26)
sue = Patient.new(name: 'sue', age: 23)
bob = Patient.new(name: 'bob', age: 24)

green_room = Room.new(name: 'green', capacity: 2)


[sally, sue, bob].each do |patient|
  puts "Is room full? #{green_room.full?}"
  begin
    green_room.add_patient(patient)
    puts "Added patient to room."
  rescue Room::CapacityReachedException
    puts "Oops, couldn't add the patient to the room"
  end
end

# Is room full? false
# Added patient to room.
# Is room full? false
# Added patient to room.
# Is room full? true
# Oops, couldn't add the patient to the room

puts "The patients are:"
green_room.patients.each do |patient|
  puts "- #{patient.name}"
end


puts "Sally's room is #{sally.room.name}, and is full? #{sally.room.full?}"
