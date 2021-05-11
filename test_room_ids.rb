require_relative 'room'
require_relative 'room_repository'

repo = RoomRepository.new('data/rooms.csv')
p repo

white_room = Room.new(name: 'white')
orange_room = Room.new(name: 'orange')

repo.add_room(white_room)
repo.add_room(orange_room)

p white_room
p orange_room

p repo
