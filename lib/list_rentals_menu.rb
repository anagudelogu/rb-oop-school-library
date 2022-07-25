require_relative './menu'

class ListRentalsMenu < Menu
  def initialize(app)
    super()
    @app = app
  end

  def display
    print 'Enter the person ID:'
    id = gets.chomp.to_i
    @app.rentals_of(id)
  end
end
