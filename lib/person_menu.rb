require_relative 'menu'

class PersonMenu < Menu
  def initialize(app)
    super()
    @app = app
  end

  def display
    print "Do you want to create a student (s) or a teacher (t)? [input letter]:\t"
    type = gets.chomp
    print "Age:\t"
    age = gets.chomp.to_i
    print "Name:\t"
    name = gets.chomp.capitalize
    case type.downcase
    when 's'
      print "Has parent permission? [Y/N]:\t"
      parent_permission = gets.chomp
      @app.create_person(type, age, name, parent_permission: parent_permission?(parent_permission))
      puts 'Person student created succesfully!'
    when 't'
      print "Specialization:\t"
      specialization = gets.chomp.capitalize
      @app.create_person(type, age, name, specialization)
      puts 'Person teacher created succesfully!'
    end
  end

  private

  def parent_permission?(char)
    return true if char.upcase == 'Y'

    false
  end
end
