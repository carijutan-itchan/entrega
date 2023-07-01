# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSession
  respond_to :json
  before_action :sign_up_params, only: [:create]

  private

  # Overriding the sign_up_params from devise controller
  def sign_up_params
    params.require(:users).permit(:contact, :first_name, :last_name, :email, :password)
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        message: "Signed up sucessfully.",
        data: Resources::Users::UsersResources.new(resource).serialize
      }, status: :ok
    else
      render json: {
         message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"
      }, status: :unprocessable_entity
    end
  end
end
