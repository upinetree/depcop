module Authorizers
  class Permission
    def initialize
      @entities = [
        Entities::User.new,
        Entities::Article.new,
      ]
    end
  end
end
