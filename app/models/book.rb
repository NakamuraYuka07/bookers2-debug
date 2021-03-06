class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def self.search(method,keyword)
    if method == "forward_match"
      @books = Book.where("title LIKE?","#{keyword}%")
    elsif method == "backward_match"
      @books = Book.where("title LIKE?","%#{keyword}")
    elsif method == "perfect_match"
      @books = Book.where("#{keyword}")
    elsif method == "partial_match"
      @books = Book.where("title LIKE?","%#{keyword}%")
    else
      @books = Book.all
    end
  end


	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
