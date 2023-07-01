# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSession
  respond_to :json
  before_action :sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   # devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :contact])
  #   devise_parameter_sanitizer.permit(:sign_up) do |user|
  #     user.permit(:first_name, :last_name, :contact)
  #   end
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :contact, :email, :password])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
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
