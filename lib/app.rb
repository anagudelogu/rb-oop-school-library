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
