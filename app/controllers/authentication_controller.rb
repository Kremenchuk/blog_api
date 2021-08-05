class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request


  def signup
    begin
      User.new(permit_user_data).save!
    rescue => e
      render json: { error: e }
    end
  end

  def authenticate
    command = AuthenticateUser.call(permit_user_data[:email], permit_user_data[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private

  def permit_user_data
    params.require('user').permit(:email, :password)
  end
end