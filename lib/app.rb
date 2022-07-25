require_relative './person'
require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './rental'

class App
  attr_reader :books, :people, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = {}
  end

  def list_books
    if @books.size.positive?
      puts 'Here are the books registered at the moment:'
      @books.each { |book| puts "Title: \"#{book.title}\" Author: #{book.author}" }
    else
      puts 'There are no books registered at the moment'
    end
  end

  def list_people
    if @people.size.positive?
      puts 'Here are the people registered at the moment:'
      @people.each { |p| puts "[#{p.class}] Name: #{p.name}, ID: #{p.id}, Age: #{p.age}" }
    else
      puts 'There are no people registered at the moment'
    end
  end

  def create_person(type, age, name, specialization = nil, parent_permission: true)
    @people << Student.new(age, name, parent_permission: parent_permission) if type == 's'
    @people << Teacher.new(age, specialization, name) if type == 't'
  end

  def create_book(title, author)
    @books << Book.new(title, author)
  end

  def create_rental(date, person_idx, book_idx)
    person = @people[person_idx]
    book = @books[book_idx]
    rental = Rental.new(date, person, book)
    if @rentals.include?(person.id)
      @rentals[person.id] << rental 
    else
      @rentals[person.id] = [rental]
    end
  end

  def rentals_of(person_id)
    rentals = @rentals[person_id] || []
    puts 'Rentals:'
    rentals.each { |rental| puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}" }
    nil
  end
end


def parent_permission?(char)
  return true if char.upcase == 'Y'

  false
end

def create_person_menu(app)
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
    app.create_person(type, age, name, parent_permission: parent_permission?(parent_permission))
    puts 'Person student created succesfully!'
  when 't'
    print "Specialization:\t"
    specialization = gets.chomp.capitalize
    app.create_person(type, age, name, specialization)
    puts 'Person teacher created succesfully!'
  end
end

def create_book_menu(app)
  print "Title:\t"
  title = gets.chomp.capitalize
  print "Author:\t"
  author = gets.chomp.capitalize
  app.create_book(title, author)
  puts 'Book created succesfully!'
end

def create_rental_menu(app)
  puts 'Please select a book from the following list by number:'
  books = app.books
  books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\" Author: #{book.author}" }
  print "Enter the desired book:\t"
  book_idx = gets.chomp.to_i

  puts 'Please select a person from the following list by number, not ID:'
  people = app.people
  people.each_with_index { |p, index| puts "#{index}) [#{p.class}] Name: #{p.name}, ID: #{p.id}, Age: #{p.age}" }
  print "Enter the person number:\t"
  person_idx = gets.chomp.to_i

  print "Please enter the date: [YYYY/MM/DD]:\t"
  date = gets.chomp

  app.create_rental(date, person_idx, book_idx)
  puts 'Rental created succesfully!'
end
