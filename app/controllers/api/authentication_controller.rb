class Api::AuthenticationController < ApplicationController

  skip_before_action :authenticate_request


  def signup
    begin
      if User.new(permit_user_data).save!
        render json: { succes: 'User is created' }, status: 201
      end
    rescue => e
      render json: { error: e }
    end
  end

  def authenticate
    command = AuthenticateUser.call(permit_user_data[:email], permit_user_data[:password])

    if command.success?
      response.set_header('Authorization', command.result)
      render json: { succes: 'Login successful' }, status: 200
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private

  def permit_user_data
    params.require('user').permit(:email, :password)
  end
end