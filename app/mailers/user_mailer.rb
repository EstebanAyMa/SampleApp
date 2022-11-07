class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activar cuenta"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Reiniciar contraseña"
  end

  def order_confirmation(user)
    mail to: user.email, subject: "Confirmar orden"
  end

  def order_dispatched(user)
    mail to: user.email, subject: "Orden procesada"
  end
end
