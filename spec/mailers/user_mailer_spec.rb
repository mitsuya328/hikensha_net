require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user, activation_token: User.new_token) }
  let(:mail) { UserMailer.account_activation(user) }
  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8'}
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8'}
    part.body.raw_source
  end

  it "account_activation" do
    #user.activation_token = User.new_token
    #mail = UserMailer.account_activation(user)
    expect(mail.subject).to eq "メールアドレスのご確認"
    expect(mail.to).to eq [user.email]
    expect(mail.from).to eq ["noreply@example.com"]
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8'}
    text_body = part.body.raw_source

    expect(text_body).to match user.name
    expect(text_body).to match user.activation_token
    expect(text_body).to match CGI.escape(user.email)

    expect(html_body).to match user.name
    expect(html_body).to match user.activation_token
    expect(html_body).to match CGI.escape(user.email)
    end
end
