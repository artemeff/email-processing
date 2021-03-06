require 'rails_helper'

describe 'EmailProcessor', type: :request do
  describe 'POST /email_processor' do
    let(:post_id) { 24 }
    let(:user_id) { 42 }

    let(:open_file) do
      ->(filename) do
        File.read(File.join(Rails.root, 'spec', 'fixtures', 'requests', filename))
      end
    end

    before do
      Fabricate(:post, id: post_id, user:
        Fabricate(:user, id: user_id, email: 'user@dev'))
    end

    it 'creates a new comment with valid params' do
      post '/email_processor', {
        headers:  open_file.('sendgrid_headers'),
        to: "1bb9a0a84e36210d87be3982d2b745f4@dev",
        from: 'John Doe <user@dev>',
        text: open_file.('sendgrid_text'),
        envelope: open_file.('sendgrid_envelope'),
        subject: 'Re: New comment',
        charsets: open_file.('sendgrid_charsets')
      }

      comment = Comment.first

      expect(response.status).to eq(200)
      expect(response.body).to eq('')
      expect(comment.text).to eq('TEST REPLY')
    end

    it 'returns error with invalid params' do
      post '/email_processor', {
        headers:  open_file.('sendgrid_headers'),
        to: 'comment.WRONG_ID@dev',
        from: 'John Doe <user@dev>',
        text: open_file.('sendgrid_text'),
        envelope: open_file.('sendgrid_envelope'),
        subject: 'Re: New comment',
        charsets: open_file.('sendgrid_charsets')
      }

      expect(response.status).to eq(200)
      expect(response.body).to eq('')
      expect(Comment.count).to eq(0)
    end
  end
end
