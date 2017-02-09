class GagMailer < ApplicationMailer

  layout 'mailer'

  def send_gags_to_subscribers
    subscribers = %w(malinovsky.dev@gmail.com m.potashnykova@gmail.com)

    @posts = Post.all.to_a

    p ENV['EMAIL_ADDRESS']
    p ENV['EMAIL_PASSWORD']

    mail(from: ENV['EMAIL_ADDRESS'], to: subscribers, subject: "Fresh top-rated 9gag's gags for you")

  end

end
