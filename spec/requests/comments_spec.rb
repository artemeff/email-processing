require 'rails_helper'

describe 'Comments', type: :request do
  describe 'POST /comments' do
    let(:commenter) { Fabricate(:user) }
    let(:author)    { Fabricate(:user) }
    let(:article)   { Fabricate(:post, user: author) }

    context 'with valid params' do
      let(:params) { Hash[user_id: commenter.id, post_id: article.id, title: 'test', text: 'text'] }

      it 'creates new comment' do
        expect {
          post '/comments', params
        }.to change{Comment.count}.by(1)

        expect(response.status).to eq(201)
        expect(response.body).to eq('')
      end

      it 'sends email to post author about new comment' do
        expect(Mail::TestMailer.deliveries.count).to eq(1)
      end
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
