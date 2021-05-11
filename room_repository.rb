require 'csv'
require_relative 'room'

class RoomRepository
  # State
  # - rooms (array)
  # Behavior
  # - add room
  # - remove room
  # - find(id)
  #   [PRIVATE]
  # - load csv
  # - store csv

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @rooms = []
    @next_id = 1
    load_csv
  end

  def add_room(room)
    room.id = @next_id
    @next_id += 1
    @rooms << room
    save_csv
  end

  # receives an id, returns a Room object!
  def find(id)
    @rooms.find { |room| room.id == id }
  end

  private

  def load_csv
    csv_options = { headers: :first_row,
                    header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:capacity] = row[:capacity].to_i
      row[:id] = row[:id].to_i
      @rooms << Room.new(row)
    end
    # now update @next_id! so there will be no conflicts/duplicates.
    @next_id = @rooms.max { |room| room.id }.id + 1 if @rooms.any?
  end

  def save_csv
    csv_options = { force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'capacity']
      @rooms.each do |room|
        csv << [room.id, room.name, room.capacity]
      end
    end
  end
end
