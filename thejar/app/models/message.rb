class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  # validations
  validates_presence_of :text


has_attached_file :img_url, styles:{
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>'
	},
		:bucket => ENV['MESSAGE_BUCKET'],
		:s3_credentials =>{
			:access_key_id=> ENV['AMAZON_ACCESS_KEY_ID'],
			:secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
		}
	 validates_attachment_content_type :img_url, :content_type=> /\Aimage\/.*\Z/


end
