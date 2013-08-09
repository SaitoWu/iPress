class Post
  include Mongoid::BaseModel
  
  belongs_to :user
  
  field :title
  field :body
end