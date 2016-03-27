class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  validates :email, presence: true, format: /@/
end
