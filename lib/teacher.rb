require_relative './person'

class Teacher < Person
  def initialize(age, specialization, name = 'Unknown', id: nil)
    super(age, name, id: id)
    @specialization = specialization
  end

  def can_use_service?
    true
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'id' => @id,
      'age' => @age,
      'name' => @name,
      'specialization' => @specialization
    }.to_json(*args)
  end

  def self.json_create(teacher)
    new(teacher['age'], teacher['specialization'], teacher['name'], id: teacher['id'])
  end
end
