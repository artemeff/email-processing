require 'rails_helper'

describe 'Comments', type: :request do
  describe 'POST /comments' do
    let(:commenter) { Fabricate(:user) }
    let(:author)    { Fabricate(:user) }
    let(:article)   { Fabricate(:post, user: author) }

    it 'with valid params' do
      expect {
        post '/comments', user_id: commenter.id, post_id: article.id, title: 'test', text: 'text'
      }.to change{Comment.count}.by(1)

      expect(response.status).to eq(201)
      expect(response.body).to eq('')
    end

    it 'with invalid params' do
      expect {
        post '/comments', text: 'test'
      }.not_to change{Comment.count}

      expect(response.status).to eq(400)
      expect(response_json).to eq({
        'status' => 'error',
        'reason' => %q(Validation failed: User can't be blank, Post can't be blank)
      })
    end
  end
end
