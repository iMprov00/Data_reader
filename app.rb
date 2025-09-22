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

class StatisticsBase
  attr_reader :students
  
  def initialize(students)
    @students = students
  end
end

class ShowAll < StatisticsBase

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

class TotalScoreStatistics < StatisticsBase
  # Общий балл каждого студента
  def calculate
    puts "Общий балл студентов"

    score = Array.new

    @students.each do |value|
      grades = value[:grades]

      score << grades[:math].to_i
      score << grades[:physics].to_i
      score << grades[:history].to_i
      score << grades[:literature].to_i
      score << grades[:literature].to_i

      puts "#{value[:name]}: #{score.sum}"

      score.clear
    end #end each
  end
end

class SubjectAverageStatistics < StatisticsBase
  # Средние баллы по предметам
  def calculate
    puts "Средний балл студентов"

    score = Array.new

    @students.each do |value|
      grades = value[:grades]

      score << grades[:math].to_i
      score << grades[:physics].to_i
      score << grades[:history].to_i
      score << grades[:literature].to_i
      score << grades[:literature].to_i

      puts "#{value[:name]}: #{score.sum / score.size}"

      score.clear
    end #end each
  end
end

class TopStudentsStatistics < StatisticsBase
  # Топ-5 студентов по общему баллу
  def calculate

  end
end

class SubjectLeadersStatistics < StatisticsBase
  # Лучшие студенты по каждому предмету
  def calculate

  end
end

class StatisticsFactory

  def self.create(type, students)
    case type
    
    when :total_score then TotalScoreStatistics.new(students)

    when :subject_score then SubjectAverageStatistics.new(students)
      
    end #end case
  end
end

data_loader = WorkWithFiles.new
students = data_loader.students

show_all = ShowAll.new(students)

total_score = StatisticsFactory.create(:total_score, students) 
subject_score = StatisticsFactory.create(:subject_score, students)

total_score.calculate

puts

subject_score.calculate
