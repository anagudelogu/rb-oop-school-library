require_relative './menu'

class ListRentalsMenu < Menu
  def initialize(app)
    super()
    @app = app
  end

  def display
    puts @app.list_people
    print 'Enter the person ID:'
    id = gets.chomp
    @app.rentals_of(id)
  end
end
