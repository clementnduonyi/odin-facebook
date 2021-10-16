class RegistrationsController < Devise::RegistrationsController
    #skip_before_action :verify_authenticity_token, only: %i[create new]

    def create
        super
        if @user.persisted?
            begin
                UserMailer.with(user: @user).welcome_email.deliver_now
            rescue
                #flash.notice = "Successfully signed up. (Welcome email not sent)"
            end
        end
    end
    private

    def sign_up_params
        params.require(:user).permit(:firstname, :surename, :gender, :avatar, :email, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:user).permit(:firstname, :surename, :gender, :avatar, :email, :password, :password_confirmation, :current_password)
    end
end