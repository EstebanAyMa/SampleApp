class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activar cuenta"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Reiniciar contraseña"
  end

  def reservation_confirmation(user)
    mail to: user.email, subject: "Confirmar reservacion"
  end

  def reservation_booked(user)
    mail to: user.email, subject: "Reservacion procesada"
  end
end
