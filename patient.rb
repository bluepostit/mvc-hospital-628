class Patient
  # State
  # - name
  # - age
  # - healed
  # - room (object!)

  # Behavior
  # - heal!
  # - (readers)

  attr_reader :name, :age
  attr_accessor :room, :id

  def initialize(attr = {})
    @id = attr[:id]
    @name = attr[:name]
    @age = attr[:age]
    @room = attr[:room]
    @healed = attr[:healed] || false
  end

  def healed?
    @healed
  end

  def heal!
    @healed = true
  end
end
