require_relative "../config/environment.rb"

class Student

    attr_accessor :id, :name, :grade

    def intialize(id = nil, name, grade)
        @id = id
        @name = name
        @grade = grade
    end

    def self.create_table
        sql = <<-SQL
            CREATE TABLE students (
                id INTEGER PRIMARY KEY,
                name TEXT,
                grade INTEGER
            )
        SQL

        DB[:conn].execute(sql)
    end
end
