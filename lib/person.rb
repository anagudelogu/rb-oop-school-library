require_relative './nameable'

class Person < Nameable
  attr_reader :id, :rentals
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end

  public

  def can_use_service?
    return true if of_age? || @parent_permission

    false
  end

  def correct_name
    @name
  end
end
