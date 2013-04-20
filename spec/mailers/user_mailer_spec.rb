require "spec_helper"

describe UserMailer do
  describe 'instructions' do
    let(:user) { mock_model(User, :email => 'juliet@capulet.it', :name => 'Juliet Capulet') }
    let(:friend) { mock_model(User, :email => 'romeo@montague.it', :name => 'Romeo Montague') }
    let(:mail) { UserMailer.friend_email(user, friend) }
    it 'renders the subject' do
      expect(mail.subject).to eq I18n.t('users.mailers.friend_mailer.subject', :name => 'Romeo Montague')
    end

    it 'renders the recipient email' do
      expect(mail.to).to eq ['juliet@capulet.it']
    end

    it 'renders the sender email' do
      expect(mail.from).to eq ['noreply@jbsocial.herokuapp.com']
    end

    it "assigns the user's name" do
      expect(mail.body.encoded).to match user.name
    end

    it "assigns the friend's name" do
      expect(mail.body.encoded).to match friend.name
    end

    it 'assigns friend profile url' do
      expect(mail.body.encoded).to match "http://localhost:3000/users/#{friend.id}"
    end
  end
end
