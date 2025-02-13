class ApplicationController < ActionController::API
  include Authenticable

  # Why before_action is Necessary:
  # before_action :authenticate_user! runs the method before every request to enforce authentication.
  # Without before_action, current_user will only be called if explicitly used in an action

  before_action :authenticate_user!

  private 
  
  # method with ! mean: method will rails exceptions or has side effect
  # authenticate_user! has sideeffect because "It renders a response and halts the request"
  def authenticate_user!
    unless current_user
      render json: { error: 'Not Authorized'}, status: :unauthorized 
    end
  end
end
