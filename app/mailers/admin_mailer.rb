class AdminMailer < ApplicationMailer
  default to: "admin@example.com.mx"

  def new_order
    mail subject: "Nueva orden"
  end

  def stock_empty(product)
    @product = product
    mail subject: "Producto no existen en almacen"
  end

  def general_message(contact)
    @contact = contact
    mail subject: "Nuevo mensaje en sitio"
  end
end
