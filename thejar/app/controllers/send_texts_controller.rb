class SendTextController < Application Controller

	def index
	end

	def send_text_message
		number_to_send_to = params[:number_to_send_to]

		twilio_sid = ENV['ACCOUNT_SID']
		twilio_token = ENV['AUTH_TOKEN']
		twilio_phone_number = 6502760630

		@twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

		@twilio.client.account.sms.messages.create(
			:from => "+1#6502760630",
			:to => number_to_send_to,
			:body => "You have been invited to join a challenge!  Go to ......blah"
			)
	end
end
