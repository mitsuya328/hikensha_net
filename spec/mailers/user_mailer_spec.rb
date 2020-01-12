require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8'}
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8'}
    part.body.raw_source
  end

  describe "account_activation" do
    let(:user) { FactoryBot.create(:user, activation_token: User.new_token) }
    let(:mail) { UserMailer.account_activation(user) }

    it "should have correct content" do
      expect(mail.subject).to eq "メールアドレスのご確認"
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["noreply@hikensha.net"]

      expect(text_body).to match user.name
      expect(text_body).to match user.activation_token
      expect(text_body).to match CGI.escape(user.email)

      expect(html_body).to match user.name
      expect(html_body).to match user.activation_token
      expect(html_body).to match CGI.escape(user.email)
    end
  end

  describe "password_reset" do
    let(:user) { FactoryBot.create(:user, reset_token: User.new_token) }
    let(:mail) { UserMailer.password_reset(user) }

    it "should have correct content" do
      expect(mail.subject).to eq "パスワードの再設定"
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["noreply@hikensha.net"]

      expect(text_body).to match user.reset_token
      expect(text_body).to match CGI.escape(user.email)

      expect(html_body).to match user.reset_token
      expect(html_body).to match CGI.escape(user.email)
    end
  end
end
