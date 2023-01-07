require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def list_people
    if @people.empty?
      puts 'There are no people in the library'
    else
      @people.each do |person|
        if person.instance_of?(Student)
          puts "[Student]: Name: #{person.name}, Id: #{person.id}, Age: #{person.age}"
        else
          puts "[Teacher]: Name: #{person.name}, Id: #{person.id}, Age: #{person.age}"
        end
      end
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp

    case person_type
    when '1'
      student = create_student
      @people << student
      puts 'Person created successfully'

    when '2'
      teacher = create_teacher
      @people << teacher
      puts 'Person created successfully'
    else
      puts 'Invalid option'
    end
  end

  def create_student
    print 'Name: '
    name = gets.chomp

    print 'Age: '
    age = gets.chomp.to_i

    print 'Classroom:'
    classroom = Classroom.new(gets.chomp)

    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp
    if parent_permission == 'Y' || parent_permission.downcase == 'y'
      parent_permission = true
    elsif parent_permission == 'N' || parent_permission.downcase == 'n'
      parent_permission = false
    else
      return nil
    end

    Student.new(age, classroom, parent_permission, name)
  end

  def create_teacher
    print 'Name: '
    name = gets.chomp

    print 'Age: '
    age = gets.chomp.to_i

    print 'Specialization: '
    specialization = gets.chomp

    Teacher.new(age, specialization, name)
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }

    book_index = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age} "
    end

    person_index = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp

    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Rental created successfully'
  end

  def list_rentals_by_person_id
    print 'ID of person: '
    id = gets.chomp.to_i

    rentals = @rentals.filter { |rental| rental.person.id == id }
    puts 'Rentals:'
    rentals.each { |rental| puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}" }
  end
end
