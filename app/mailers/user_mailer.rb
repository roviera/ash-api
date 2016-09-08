class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Tu solicitud de cuenta ha sido recibida')
  end

  def accepted_user_email(user)
    @user = user
    mail(to: @user.email, subject: 'Tu solicitud de cuenta ha sido aceptada')
  end

  def rejected_user_email(user)
    @user = user
    mail(to: @user.email, subject: 'Tu solicitud de cuenta ha sido rechazada')
  end
end