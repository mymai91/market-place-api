class OrderMailer < ApplicationMailer
  include ActionView::Helpers::NumberHelper
  default from: 'no-reply@marketplace.com'

  def send_confirmation(order)
    @order = order
    @user = @order.user
    @products = @order.products

    mail to: @user.email, subject: "Order Confirmation"
  end

  def format_price(price)
    # number_to_currency(price)
    ActionController::Base.helpers.number_to_currency(amount)
  end
end
