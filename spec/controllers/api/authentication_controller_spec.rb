require 'rails_helper'

describe Api::AuthenticationController, type: :request  do #AuthenticationController

  # create new user
  let(:signup_url) { '/api/signup' }
  # login and take auth. token
  let(:login_url) { '/api/login' }


  user = FactoryBot.build(:user)


  context 'When creating a new user' do
    before do
      post signup_url, params: {
          user: {
              email: user.email,
              password: user.password
          }
      }
    end

    it 'returns 201' do
      expect(response.status).to eq(201)
    end
  end


  context 'When login' do
    before do
      user.save!
      post login_url, params: {
          user: {
              email: user.email,
              password: user.password
          }
      }
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end
  end

end