require_relative './person'
require_relative './student'
require_relative './teacher'
require_relative './book'
require_relative './rental'
require 'json'

class App
  attr_reader :books, :people, :rentals

  def initialize
    @books = read_data('books')
    @people = read_data('people')
    @rentals = read_rentals('rentals')
  end

  def read_data(file_name)
    if File.file?("data/#{file_name}.json")
      hash = File.open("data/#{file_name}.json") { |f| JSON.parse(f.read, create_additions: true) }
      return hash[file_name]
    end
    file_name == 'rentals' ? {} : []
  end

  def read_rentals(file_name)
    hash = read_data(file_name)
    rentals_hash = {}
    hash.keys.map do |key|
      hash[key].map do |rental|
        # search for the person matching the id
        person = @people.find { |p| p.id == rental[:person_id] }
        # search for the book matching the title
        book = @books.find { |b| b.title == rental[:book_title] }
        # Create a new rental.
        rental = Rental.new(rental[:date], person, book)
        if rentals_hash.include?(person.id)
          rentals_hash[person.id] << rental
        else
          rentals_hash[person.id] = [rental]
        end
      end
    end
    rentals_hash
  end

  def write_data
    files = [
      { name: 'people', payload: @people },
      { name: 'books', payload: @books },
      { name: 'rentals', payload: @rentals }
    ]

    files.each do |file|
      File.open("data/#{file[:name]}.json", 'w') do |f|
        data_hash = { file[:name] => file[:payload] }
        json = JSON.pretty_generate(data_hash)
        f.write(json)
      end
    end
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
    nil
  end

  def create_person(type, age, name, specialization = nil, parent_permission: true)
    @people << Student.new(age, name, parent_permission: parent_permission) if type == 's'
    @people << Teacher.new(age, specialization, name) if type == 't'
  end

  def create_book(title, author)
    @books << Book.new(title, author)
  end

  def create_rental(date, person, book)
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
    puts 'No rentals under this ID' if rentals.empty?
    rentals.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}, Rented by: #{rental.person.name}"
    end
    nil
  end
end
