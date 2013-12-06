require 'amqp'
def prompt
  STDERR.<< "\nRequest Path: /"
end

AMQP.start(host: 'localhost') do |client|

  chan = AMQP::Channel.new(client)

  chan.queue("test.simple.reply", auto_delete: true).subscribe do |payload|
    puts "Got a reply:"
    puts payload
    prompt
  end
  $haha = chan

  module KeyHandler
    include EM::Protocols::LineText2
    def receive_line data
      $haha.direct("").publish("/#{data}", routing_key: "test.simple")
    end
  end
  EventMachine.open_keyboard(KeyHandler)

  prompt
end
