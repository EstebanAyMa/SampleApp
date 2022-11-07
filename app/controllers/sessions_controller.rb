class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or root_path
      else
        message  = "Cuenta no activada! "
        message += "Por favor, verifique su correo electronico para activarla."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Correo electronico o contraseña invalida."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
