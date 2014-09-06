class User < ActiveRecord::Base
  has_many :messages
  has_many :user_challenges
  has_many :challenges, :through => :user_challenges

  attr_accessor :avatar

	has_secure_password

	validates :email, presence: true, uniqueness: true
	validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i, :multiline => true
	validates :password, confirmation: true, presence: true, :length => {:minimum => 6}, on: :create
	validates :password_confirmation, presence: true, on: :create
	validates_presence_of :first_name
	validates_presence_of :last_name
	validates :phone_number, presence: true, length: {is: 12}
	# validates_format_of :phone_number, :with => /\A(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?\z/i
	validates :avatar,
						attachment_size:{less_than: 5.megabytes}

	def self.authenticate email, password
		User.find_by_email(email).try(:authenticate, password)
	end

	def set_password_reset
		self.code = SecureRandom.urlsafe_base64
		self.expires_at = 4.hours.from_now
		self.save!
	end

	has_attached_file :avatar,
	styles:{
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>'
	},
		:bucket => ENV['BUCKET_NAME'],
		:storage => :s3,
		# :s3_host_name => 's3-us-west-1.amazonaws.com',
		:url => 's3_domain_url',
    :path => '/:class/:attachment:/:id_partition/:style/:filename',
		:s3_credentials =>{
			:access_key_id=> ENV['AMAZON_ACCESS_KEY_ID'],
			:secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
		}


	validates_attachment_content_type :avatar, :content_type=> /\Aimage\/.*\Z/

end
