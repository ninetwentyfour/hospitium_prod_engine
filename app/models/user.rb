User.class_eval do
  require 'sendgrid-ruby'

  after_create :send_new_email
  before_save :send_user_confirmed_email

  def send_user_confirmed_email
    unless self.no_send_email == true
      if self.confirmed_at_changed?
        unless Rails.env.test?
          $statsd.increment 'user.activated'
          mail = SendGrid::Mail.new do |m|
            m.to = 'contact@travisberry.com'
            m.from = 'contact@hospitium.co'
            m.subject = 'Hospitium User Confirmed'
            m.text = "#{username} confirmed an account. #{email} in organization #{organization_name}"
          end
          sengrid_client.send(mail)
        end
      end
    end
  rescue
  end

  def send_new_email
    unless Rails.env.test? || (no_send_email == true)
      $statsd.increment 'user.created'
      mail = SendGrid::Mail.new do |m|
        m.to = 'contact@travisberry.com'
        m.from = 'contact@hospitium.co'
        m.subject = 'Hospitium New User'
        m.text = "#{username} created an account. #{email} in organization #{organization.name}"
      end
      sengrid_client.send(mail)
    end
  rescue
  end

  def sengrid_client
    @client ||= SendGrid::Client.new(api_key: ENV['SENDGRID_PASSWORD'])
  end
end
