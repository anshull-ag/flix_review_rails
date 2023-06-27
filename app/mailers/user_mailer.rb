class UserMailer < ApplicationMailer
  default from: "movieshub@gmail.com"

  def user_confirmation_email(user)
    @user = user
    @url = 'http://127.0.0.1:3000/users/sign_in'

    mail(to: @user.email, subject: "Your Signup Successfully, Welcome to world's best movies review website")
  end
end
