class Post
  include Mongoid::BaseModel

  belongs_to :user

  field :title
  field :body

  self.per_page = 10

  validates_presence_of :title, :body
  validates_length_of :title, :within => 3..100
end
