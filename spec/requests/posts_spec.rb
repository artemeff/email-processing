require 'rails_helper'

describe 'Posts', type: :request do
  context 'GET /posts' do
    before { Fabricate.times(3, :post) }

    it 'retrieves all posts' do
      get '/posts'
      expect(response.status).to eq(200)
      expect(response_json.count).to eq(3)
      expect(response_json.first.keys).to match_array(
        %w[id user_id title text created_at updated_at])
    end
  end

  context 'POST /posts' do
    let(:user) { Fabricate(:user) }

    it 'with valid params' do
      expect {
        post '/posts', title: 'test', text: 'text', user_id: user.id
      }.to change{Post.count}.by(1)

      expect(response.status).to eq(201)
      expect(response.body).to eq('')
    end

    it 'with invalid params' do
      expect {
        post '/posts', title: 'test'
      }.not_to change{Post.count}

      expect(response.status).to eq(400)
      expect(response_json).to eq({
        'status' => 'error',
        'reason' => %q(Validation failed: User can't be blank, Text can't be blank)
      })
    end
  end

  context 'GET /posts/:id' do
    let(:author)     { Fabricate(:user) }
    let(:commenter)  { Fabricate(:user) }
    let(:post)       { Fabricate(:post, user: author) }
    let!(:comments)  { Fabricate.times(5, :comment, post: post) }

    it 'retrieves all comments for existent post' do
      get "/posts/#{post.id}"

      expect(response.status).to eq(200)
      expect(response_json.keys).to match_array(
        %w[id author comments title text created_at updated_at])
      expect(response_json['author'].keys).to match_array(%w[id email name])
      expect(response_json['comments'].first.keys).to match_array(
        %w[id user_id text created_at updated_at])
      expect(response_json['comments'].count).to eq(5)
    end

    it 'returns 404 when post does not exist' do
      get '/posts/42'

      expect(response.status).to eq(404)
      expect(response.body).to eq('')
    end
  end
end
