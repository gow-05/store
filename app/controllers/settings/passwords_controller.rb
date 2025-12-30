class Settings::PasswordsController < Settings::BaseController
  # allow_unauthenticated_access
  # before_action :set_user_by_token, only: %i[ edit update ]
  # rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_password_path, alert: "Try again later." }

  # def new
  # end

  # def create
  #   if user = User.find_by(email_address: params[:email_address])
  #     PasswordsMailer.reset(user).deliver_later
  #   end

  #   redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email address exists)."
  # end
  def show
  end

  # def edit
  # end


  def update
    if Current.user.update(password_params)
      redirect_to settings_profile_path, status: :see_other, notice: "Your password has been updated."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
    def password_params
      params.expect(user: [ :password, :password_confirmation, :password_challenge ]).with_defaults(password_challenge: "")
    end
end
