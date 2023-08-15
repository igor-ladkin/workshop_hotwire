class LiveStationChannel < ApplicationChannel
  def subscribed
    puts "hello"
  end

  def unsubscribed
    puts "goodbye"
  end
end
