class Post < Virtus::ActiveRecord.model
  attribute :author, User
  attribute :title, String
  attribute :body, String
end
