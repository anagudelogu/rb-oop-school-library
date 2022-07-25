require_relative './menu'

class RentalsMenu < Menu
  def initialize(app)
    super()
    @app = app
  end

  def display
    puts 'Please select a book from the following list by number:'
    books = @app.books
    books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\" Author: #{book.author}" }
    print "Enter the desired book:\t"
    book_idx = gets.chomp.to_i

    puts 'Please select a person from the following list by number, not ID:'
    people = @app.people
    people.each_with_index { |p, index| puts "#{index}) [#{p.class}] Name: #{p.name}, ID: #{p.id}, Age: #{p.age}" }
    print "Enter the person number:\t"
    person_idx = gets.chomp.to_i

    print "Please enter the date: [YYYY/MM/DD]:\t"
    date = gets.chomp

    @app.create_rental(date, person_idx, book_idx)
    puts 'Rental created succesfully!'
  end
end
