# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def sign_in_params
    params.require(:users).permit(:email, :password)
  end

  def respond_with(resource, _opts = {})
    render json: {
      message: 'Logged in sucessfully.',
      data: Resources::Users::UsersResources.new(resource).serialize
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
