class Room
  # State
  # - name
  # - capacity
  # - patients
  # - id
  # Behavior
  # - add patient
  # - full?

  class CapacityReachedException < Exception; end

  attr_reader :name, :capacity, :patients
  attr_accessor :id

  def initialize(attr = {})
    @name = attr[:name]
    @capacity = attr[:capacity] || 0
    @id = attr[:id]
    @patients = []
  end

  def add_patient(patient)
    if full?
      fail CapacityReachedException, 'The room is full'
    else
      @patients << patient
      patient.room = self
    end
  end

  def full?
    @patients.length >= @capacity
  end
end
