class Event < ActiveRecord::Base

	validates :name, presence: true, uniqueness: true
	validates :slug, uniqueness: true
	validates :location, presence: true
	validates :description, length: { minimum: 25 }
	validates :price, numericality: { greater_than_or_equal_to: 0 }
	validates :capacity, numericality: { only_integer: true, greater_than: 0 }
	validates :image_file_name, allow_blank: true, format: {
		with: /\w+\.(gif|jpg|png)\z/i,
		message: "must reference a GIF, JPG, or PNG image"
	}
	validate :price_is_a_multiple_of_fifty_cents	
	
	has_many :registrations, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :likers, through: :likes, source: :user
	has_many :categorizations, dependent: :destroy
	has_many :categories, through: :categorizations

	before_validation :generate_slug

	scope :past, -> {where('starts_at < ?', Time.now).order(:starts_at)}
	scope :upcoming, -> {where('starts_at >= ?', Time.now).order(:starts_at)}
	scope :free, -> {upcoming.where(price: 0).order(:name)}
	scope :recent, ->(max=3) {past.limit(max)}
	scope :past_n_days, ->(days) { where('created_at >= ?', days.days.ago) }
	scope :inexpensive, -> { where('price <= 15').order('price DESC') }
	scope :everything, -> { order(starts_at: :asc) }

		
	def free?
		price.blank? || price.zero?
	end	
	
	def spots_left
		if capacity.zero?
			0
		else
			capacity - registrations.size
		end
	end
	
	def sold_out?
		spots_left.zero?
	end

	def to_param
		slug
	end

	def generate_slug
		self.slug ||= name.parameterize if name
	end
	
private

	def price_is_a_multiple_of_fifty_cents
		if errors[:price].empty?
			# unless (price * 100).remainder(50) == 0
			unless (price * 100) % 50 == 0
				errors[:price] << "must be a multiple of fifty cents"
			end
		end
	end

end