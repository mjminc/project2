class PasswordsController < ApplicationController

	def create
		user = User.find_by_email(params[:email])
		if user
			user.set_password_reset
			UserMailer.password_reset(user).deliver
			# redirect_to root_url
		end
		redirect_to login_url, notice: "Please respond to email immediately"
	end


	def edit
		@user = User.find_by_code(params[:id])
	end


	def update
		@user = User.find_by_code(params[:id])

		if @user
			update_password = params.require(:user).permit(:password, :password_confirmation)
			@user.update_attributes(update_password)
			@user.save
			redirect_to "/"
		end
	end

end
