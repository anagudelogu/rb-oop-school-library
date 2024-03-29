class Rental
  attr_reader :person, :book
  attr_accessor :date

  def initialize(date, person, book)
    @date = date
    @person = person
    @person.rentals << self
    @book = book
    @book.rentals << self
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'date' => @date,
      'person' => @person,
      'book' => @book
    }.to_json(*args)
  end

  def self.json_create(rental)
    new(rental['date'], rental['person'], rental['book'])
  end
end
