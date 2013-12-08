# current state

Still building out examples. Racked rails works though with userland at
least, `cd userland; be ../rack-amqp/bin/raqup config.ru` to start the
server; use `../sample_client.rb` to query (try `/users`)


# Actors

* `userland` provides the User concept to the system 
  * `userland` has no interface other than json
  * `userland` is pretty vanilla
* `interface` provides a UI
* `bloghie` is a rails-api app that provides a blog
  * `bloghie` uses some tricks (virtus-activerecord, rails-api)

### Models

```
User
  +id
  +login
  +password (not crypted, meh)

Post
  +id
  +author_id
  +title
  +body

Comment
  +id
  +post_id
  +user_id
  +body
```

### Relationships

In the `bloghie` context:
```
User
  many :posts
  many :comments

Post
  many :comments
```