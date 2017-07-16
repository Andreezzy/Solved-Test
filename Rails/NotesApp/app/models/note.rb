class Note < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 10 }

  before_save :set_visits_count

  def self.search(search)
  	if search
  		Note.where("title LIKE ? or body LIKE ?", "%#{search}%", "%#{search}%")
  	else
  		Note.all
  	end
  end

  def update_visits_count
		self.save if self.num_views.nil?
		self.update(num_views: self.num_views + 1)
	end

	private
	def set_visits_count
		self.num_views ||= 0
	end

end
