require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
   include Singleton
   
   def initialze
     super('questions.db')
     self.type_translation = true
     self.results_as_hash = true
   end
end

class Users
    attr_accessor :author_id , :fname, :lname
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| Users.new(datum) }
    end

    def self.find_by_id(author_id)
        id = QuestionsDatabase.instance.execute(<<-SQL, author_id)
          SELECT
            *
          FROM
            users
          WHERE
            author_id = ?
        SQL
        return nil if id.nil?
    
        User.new(id.first) # id is stored in an array
    end

    def initialize(options)
        @author_id = options['author_id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def create
        raise "#{self} already in database" if @author_id
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
          INSERT INTO
            users (fname, lname)
          VALUES
            (?, ?)
        SQL
        @author_id = QuestionsDatabase.instance.last_insert_row_id
    end
    
    def update
        raise "#{self} not in database" unless @author_id
        PlayDBConnection.instance.execute(<<-SQL, @fname, @lname, @author_id)
          UPDATE
            users
          SET
            fname = ?, lname = ?
          WHERE
            author_id = ?
        SQL
    end
end


# class Questions
#     attr_accessor :questions_id, :title, :body , :author_id
#     def self.all
#         data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
#         data.map { |datum| Questions.new(datum) }

#     end

#     def initialize(attribute)
#       @attribute = attribute
#     end

#     def create

#     end
    
#     def update

#     end

# end

# class Question_follows
#     attr_accessor :question_follows_id, :author_id, :questions_id
#     def self.all
#         data = QuestionsDatabase.instance.execute("SELECT * FROM questions_follows")
#         data.map { |datum| Question_follows.new(datum) }
#     end

#     def initialize(attribute)
#       @attribute = attribute
#     end

#     def create

#     end
    
#     def update

#     end

# end

# class Replies
#     attr_accessor :replies_id, :reply, :questions_id, :parent_id, :author_id
#     def self.all
#         data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
#         data.map { |datum| Replies.new(datum) }
#     end

#     def initialize(attribute)
#       @attribute = attribute
#     end

#     def create

#     end
    
#     def update

#     end

# end


# class Question_likes
#     attr_accessor :author_id, :questions_id, :likes
#     def self.all
#         data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
#         data.map { |datum| Question_likes.new(datum) }
#     end

#     def initialize(attribute)
#       @attribute = attribute
#     end

#     def create

#     end
    
#     def update

#     end

# end