require_relative "../config/environment.rb"

class Student

    attr_accessor :name, :grade
    attr_reader :id

    def initialize(name, grade, id = nil)
        @name = name
        @grade = grade
        @id = id
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

    def self.drop_table
        DB[:conn].execute("DROP TABLE IF EXISTS students")
    end

    def save
        if self.id
            self.update
        else
            sql = <<-SQL
                INSERT INTO students (name, grade)
                VALUES (?, ?)
            SQL

            DB[:conn].execute(sql, self.name, self.grade)
            @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
        end
    end

    def self.create(name, grade)
        new = self.new(name, grade)
        sql = <<-SQL
            INSERT INTO students (name, grade)
            VALUES (?, ?)
        SQL

        DB[:conn].execute(sql, new.name, new.grade)
        new.id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    end

    def update
    end
end
