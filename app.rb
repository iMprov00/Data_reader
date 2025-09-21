require 'csv'

class WorkWithFiles
  attr_reader :students

  def initialize
    @students = []
    write_in_array
  end

  def filename
    'grades.txt'
  end

  def write_in_array
    CSV.foreach(filename, headers: true, converters: :numeric) do |row|
      student = 
      {
        group: row['Группа'],
        name: "#{row['Имя']} #{row['Фамилия']}",
        grades: 
        {
          math: row['Математика'],
          physics: row['Физика'],
          history: row['История'],
          literature: row['Литература'],
          programming: row['Программирование']
        }
      }
      @students << student
    end
  end
end

class ShowAll
  def initialize
    @students = WorkWithFiles.new.students
  end

  def show_students
    group = ''
    @students.each do |g|
      if group != g[:group]
        puts "Группа: #{g[:group]}"
        @students.each do |value|
          puts "#{value[:name]}, #{value[:grades][:math]}"
        end
        puts "============="
        group = g[:group]
      end 
    end
  end
end

show_all = ShowAll.new

show_all.show_students

