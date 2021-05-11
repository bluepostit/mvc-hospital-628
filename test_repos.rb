require_relative 'patient_repository'
require_relative 'room_repository'

rooms_csv_file = 'data/rooms.csv'
room_repo = RoomRepository.new(rooms_csv_file)
patients_csv_file = 'data/patients.csv'
patient_repo = PatientRepository.new(patients_csv_file, room_repo)

p patient_repo
