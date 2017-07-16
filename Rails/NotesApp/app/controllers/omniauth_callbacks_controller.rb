class OmniauthCallbacksController < ApplicationController
	#skip_before_action :authenticate_user!, only: [:facebook, :custom_sign_up]
  def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
			@user.remember_me = true
			sign_in_and_redirect @user, event: :authentication
			return
		end

		session["devise.auth"] = request.env["omniauth.auth"]

		render :edit

	end

  def failure
	  redirect_to root_path, notice: "Error: #{params[:error_description]}. Motivo: #{params[:error_reason]}"
	end

	private

	def user_params
	  params.require(:user).permit(:name, :last_name,	:email)
	end
end
