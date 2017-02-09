every 5.minutes do
  runner 'Post.delete_old'
  runner 'Post.get_new'
end

every '0 11 * * *' do
  runner 'GagMailer.send_gags_to_subscribers.deliver_now'
end
