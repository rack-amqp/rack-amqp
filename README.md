# rack-amqp

I want to be able to run a rack app (rails, sinatra, etc) under an AMQP
endpoint (no HTTP!).  I'm experimenting with this stuff here. If you
have ideas, open an issue or submit a PR! :)

1. install [RabbitMQ](http://www.rabbitmq.com/)
1. `bundle install`
1. In one terminal, run `ruby rackable.rb simple.ru`
1. In another terminal, run `ruby sample_client.rb`
1. Try it out!
