class Post < ApplicationRecord

	validates :title, presence: true, length: { minimum: 3}
	validates :summary, presence: true, length: { minimum: 10 }
	validates :body, presence: true, length: { maximum: 300 }

	belongs_to :user, optional: true
	belongs_to :category, optional: false
	# Add Image to Post
	has_one_attached :main_image

	has_many :comments

	def details
		"This post was created on #{ created_at.strftime("%d %m %Y") }"
	end

	def self.total
		#returns a total number of posts
		all.size
	end

	#callbacks - validations / save/ update / create /destroy
	after_create :update_total_posts_count

	scope :active, -> { where( active:true) }
	scope :order_by_latest_first, -> { order( created_at: :desc ) }
	scope :limit_2, -> { limit( 2 )}

	private

	def update_total_posts_count
		#update category total count column to show total post counts
		category.increment(:total_count, 1).save
	end

end
