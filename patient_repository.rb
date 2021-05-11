require 'csv'
require_relative 'patient'

class PatientRepository
  # State
  # - patients (array)
  # Behavior
  # - add patient
  # - remove patient
  #   [PRIVATE]
  # - load csv
  # - store csv

  def initialize(csv_file_path, room_repository)
    @csv_file_path = csv_file_path
    @room_repository = room_repository
    @next_id = 1
    @patients = []
    load_csv
  end

  def add_patient(patient)
    patient.id = @next_id
    @next_id += 1
    @patients << patient
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row,
                    header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # healed must be a boolean
      row[:healed] = row[:healed] == 'true'
      # age, id must be integers
      row[:age] = row[:age].to_i
      row[:id] = row[:id].to_i

      # get room from RoomRepository instance using row[:room_id]
      room_id = row[:room_id].to_i
      room = @room_repository.find(room_id)
      row[:room] = room

      @patients << Patient.new(row)
    end
    @next_id = @patients.max { |patient| patient.id }.id + 1 if @patients.any?
  end

  def save_csv
    csv_options = { force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['name', 'age', 'healed']
      @patients.each do |patient|
        csv << [patient.name, patient.age, patient.healed?]
      end
    end
  end
end
