## README

Used Ruby 2.2.0, Rails 4.2.0, Bootstrap 3

The app allows you to view the best 9gag posts created in the past day, without having to manually scrolling the 9gag's homepage viewing tons of anime, cosplay, pokemons, and other not so interesting content. Usually posts with more than 10 000 upvotes are really good, so app checks 9gag for these posts every minute, saves they to database. Also every minute app delete from DB posts that been added more than 1 day ago.

Master branch is well-tested on my own server, but heroku version isn't, because I don't wont to give Heroku access to my credit card. Without verified account Heroku doesn't allows you to run more than one process on app startup, so app works only until the first server restart. And they restart their servers at least one time per day.

Quickstart
----------

Use master branch for server with free access to cron jobs:

cd to project's directory and run
```
whenewer -w
```

Than check your crontab by running
```
crontab -l
```

Output must contain something like:

    # Begin Whenever generated tasks for: /home/max/MEGAsync/best-of-today-9gag/config/schedule.rb
    * * * * * /bin/bash -l -c 'cd /home/max/MEGAsync/best-of-today-9gag && bin/rails runner -e production '\''Post.delete_old'\'''
    
    * * * * * /bin/bash -l -c 'cd /home/max/MEGAsync/best-of-today-9gag && bin/rails runner -e production '\''Post.get_new'\'''
    
    
    # End Whenever generated tasks for: /home/max/MEGAsync/best-of-today-9gag/config/schedule.rb

To disable cron job run
```
whenever -c
```

Using this method cron will continue refreshing posts in background even when main app not running

Quickstart with Heroku
----------------------

Master branch will not work on Heroku. Use heroku-version branch for it. As i wrote at the top, i can't normally test it on Heroku. If you do that, please let me know by email [malinovsky.dev@gmail.com](mailto:malinovsky.dev@gmail.com).

Theoretically, to run this app on Heroku you must:

Push app to heroku master
Run
```
heroku scale clock=1
```
To check running processes run:
```
heroku ps
```
If everything working fine, you must see something like:

    === web (Free): `bundle exec rails s -p $PORT`
    web.1: idle 2015/08/24 18:08:16 (~ 1h ago)
    
    === clock (Free): `bundle exec clockwork clock.rb`
    clock.1 (Free): up 2015/08/24 17:24:26 (~ 1h ago)

If you don't have verified account, you can start clock process manually by running:
```
heroku run clockwork clock.rb
```

App must work fine until first server reboot (they reboot at least one time per day).
If app work fine it will respond to command:
```
heroku ps
```

with something like:

    === run: one-off processes
    run.9497 (Free): up 2015/08/24 17:24:26 (~ 1h ago): `clockwork clock.rb`
    
    === web (Free): `bundle exec rails s -p $PORT`
    web.1: idle 2015/08/24 18:08:17 (~ 1h ago)
