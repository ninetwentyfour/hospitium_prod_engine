User.class_eval do
  require 'sendgrid-ruby'

  after_create :send_new_email

  def send_new_email
    unless Rails.env.test? || (no_send_email == true)
      $statsd.increment 'user.created'
      client = SendGrid::Client.new(api_key: ENV['SENDGRID_PASSWORD'])
      mail = SendGrid::Mail.new do |m|
        m.to = 'contact@travisberry.com'
        m.from = 'contact@hospitium.co'
        m.subject = 'Hospitium New User'
        m.text = "#{username} created an account. #{email} in organization #{organization.name}"
      end
      client.send(mail)
    end
  rescue => e
    notify_airbrake(e)
  end
end
