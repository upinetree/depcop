module Entities
  class User
    def initialize
      @auth = Authorizers::Permission.new
    end
  end

  class Article
    def initialize
      @auth = Authorizers::Permission.new
    end
  end

  class Comment
    def initialize
      @auth = Authorizers::Permission.new
    end
  end
end
