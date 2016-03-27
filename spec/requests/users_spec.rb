require 'rails_helper'

describe 'Users', type: :request do
  describe 'GET /users' do
    before { Fabricate.times(3, :user) }

    it 'retrieves all users' do
      get '/users'
      expect(response.status).to eq(200)
      expect(response_json.count).to eq(3)
      expect(response_json.first.keys).to match_array(
        %w[id email name created_at updated_at])
    end
  end

  describe 'POST /users' do
    it 'with valid params' do
      expect {
        post '/users', name: 'John Doe', email: 'dev@test'
      }.to change{User.count}.by(1)

      expect(response.status).to eq(201)
      expect(response.body).to eq('')
    end

    it 'with invalid params' do
      expect {
        post '/users', email: 'malformed_email'
      }.not_to change{User.count}

      expect(response.status).to eq(400)
      expect(response_json).to eq({
        'status' => 'error',
        'reason' => 'Validation failed: Email is invalid'
      })
    end
  end
end
