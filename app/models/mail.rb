#

require 'postmark'
require 'mail'

class Mailer

  def initialize
  end

  def self.send to = 'hello@joshellington.com', subject, body
    message = Mail.new
    message.from = "hello@joshellington.com"
    message.to = to
    message.subject = subject
    message.body = body
    message.delivery_method(Mail::Postmark, :api_key => "738c0a38-e581-4251-bde5-94e886252110")

    message.deliver
  end

  def self.get
    # Get an email
  end
end