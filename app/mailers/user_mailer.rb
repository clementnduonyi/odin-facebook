class UserMailer < ApplicationMailer
    default from: 'notifications@odinsocial.com'

    def welcome_email
        @user = params[:user]
        @url  = 'http://odinsocial.com/login'
        mail(to: "#{@user.email}, subject: Welcome to My Awesome Site #{@user.firstname}")
    end
end
