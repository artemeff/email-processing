require 'rails_helper'

describe Notifications, type: :mailer do
  context '#new_comment' do
    let(:author)    { Fabricate(:user) }
    let(:post)      { Fabricate(:post, user: author) }
    let(:commenter) { Fabricate(:user) }
    let(:comment)   { Fabricate(:comment, user: commenter, post: post, text: 'nice article!') }
    let(:mail)      { Notifications.new_comment(post, author, commenter, comment) }

    it 'renders the headers' do
      expect(mail.subject).to eq('New comment')
      expect(mail.to).to eq([author.email])
      expect(mail.from).to eq(['robot@dev'])
      expect(mail.reply_to).to eq(["comment.#{post.id}@dev"])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(author.display_name)
      expect(mail.body.encoded).to match(post.title)
      expect(mail.body.encoded).to match(commenter.display_name)
      expect(mail.body.encoded).to match(comment.text)
    end
  end
end
