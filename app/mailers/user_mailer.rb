class UserMailer < ApplicationMailer
    default from: "shannellechua@gmail.com"
    layout 'mailer'
    
    def approve _email(user)
      @user = user
      mail(to: @user.email, subject: "You're Ready for Trading!")
    end
  end