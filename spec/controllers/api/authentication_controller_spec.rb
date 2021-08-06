require 'rails_helper'

describe Api::AuthenticationController, type: :request  do #AuthenticationController

  let(:user) { build_user }
  let(:existing_user) { create_user }
  let(:signup_url) { '/api/signup' }
  let(:user) { create_user }
  let(:login_url) { '/api/login' }

  context 'When creating a new user' do
    before do
      post signup_url, params: {
          user: {
              email: user.email,
              password: user.password
          }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns the user email' do
      expect(json['data']).to have_attribute(:email).with_value(user.email)
    end
  end

  #
  # context 'When logging in' do
  #   before do
  #     login(user)
  #   end
  #
  #   it 'returns a token' do
  #     expect(response.headers['Authorization']).to be_present
  #   end
  #
  #   it 'returns 200' do
  #     expect(response.status).to eq(200)
  #   end
  # end
  #
  # context 'When password is missing' do
  #   before do
  #     post login_url, params: {
  #         user: {
  #             email: user.email,
  #             password: nil
  #         }
  #     }
  #   end
  #
  #   it 'returns 401' do
  #     expect(response.status).to eq(401)
  #   end
  #
  # end
  #
  #
  # context 'When an email already exists' do
  #   before do
  #     post signup_url, params: {
  #         user: {
  #             email: existing_user.email,
  #             password: existing_user.password
  #         }
  #     }
  #   end
  #
  #   it 'returns 400' do
  #     expect(response.status).to eq(400)
  #   end
  # end

end