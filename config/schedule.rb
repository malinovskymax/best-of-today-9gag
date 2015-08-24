every 1.minute do
  runner 'Post.delete_old'
  runner 'Post.get_new'
end