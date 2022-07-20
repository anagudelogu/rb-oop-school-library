#!/usr/bin/env ruby

require './lib/person'
require './lib/student'
require './lib/teacher'
require './lib/book'

class App
  def initialize
    @people = []
    @books = []
  end

  def list_books
    if @books.size.positive?
      puts 'Here are the people registered at the moment:'
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
end

def print_menu
  puts
  puts "Welcome to School Library App!

  Please choose an option by entering a number:
    1 - List all books
    2 - List all people
    3 - Create a person
    4 - Create a book
    5 - Create a rental
    6 - List all rentals for a given person id
    7 - Exit"

  print "Enter your option here:\t"
end

def parent_permission?(char)
  return true if char.upcase == 'Y'

  false
end

def create_person_menu(app, type)
  case type.downcase
  when 's'
    print "Age:\t"
    age = gets.chomp
    print "Name:\t"
    name = gets.chomp
    print "Has parent permission? [Y/N]:\t"
    parent_permission = gets.chomp
    app.create_person(type, age.to_i, name, parent_permission: parent_permission?(parent_permission))
    puts 'Person student created succesfully!'
  when 't'
    print "Age:\t"
    age = gets.chomp
    print "Name:\t"
    name = gets.chomp
    print "Specialization:\t"
    specialization = gets.chomp
    app.create_person(type, age.to_i, name, specialization)
    puts 'Person teacher created succesfully!'
  end
end

def create_book_menu(app)
  print "Title:\t"
  title = gets.chomp
  print "Author:\t"
  author = gets.chomp
  app.create_book(title, author)
  puts 'Book created succesfully!'
end

# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
def main
  app = App.new
  loop do
    print_menu
    option = gets.chomp.to_i
    puts 'Please enter a valid option' if option < 1 || option > 7
    case option
    when 1
      app.list_books
    when 2
      app.list_people
    when 3
      print "Do you want to create a student (s) or a teacher (t)? [input letter]:\t"
      type = gets.chomp
      create_person_menu(app, type)
    when 4
      create_book_menu(app)
    when 5
      puts 'You chose Create a rental'
    when 6
      puts 'You chose list all rentals for a given id'
    when 7
      puts 'Thank you for using this app, until next time!'
      break
    end
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
main
