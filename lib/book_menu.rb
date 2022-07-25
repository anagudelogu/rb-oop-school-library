require_relative './menu'

class BookMenu < Menu
  def initialize(app)
    super()
    @app = app
  end

  def display
    print "Title:\t"
    title = gets.chomp.capitalize
    print "Author:\t"
    author = gets.chomp.capitalize
    @app.create_book(title, author)
    puts 'Book created succesfully!'
  end
end
