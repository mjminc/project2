class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  attr_accessor :msgpic
  # validations
  validates_presence_of :text
  validates :msgpic,
  					attachment_size:{less_than: 5.megabytes}

has_attached_file :msgpic, styles:{
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>'
	},
		:bucket => ENV['MESSAGE_BUCKET'],
    :storage => :s3,
			:url => 's3_domain_url',
    :path => '/:class/:attachment:/:id_partition/:style/:filename',
		:s3_credentials =>{
			:access_key_id=> ENV['AMAZON_ACCESS_KEY_ID'],
			:secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
		}
	 validates_attachment_content_type :msgpic, :content_type=> /\Aimage\/.*\Z/


	before_post_process :set_content_type

	def set_content_type
	  self.sketch.instance_write(:content_type, MIME::Types.type_for(self.sketch_file_name).to_s)
	end

end
