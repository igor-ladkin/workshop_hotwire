class LiveStationChannel < ApplicationChannel
  def subscribed
    station.increment_listeners_count
    puts "There are #{station.listeners_count} listeners on #{station.name}"
  end

  def unsubscribed
    station.decrement_listeners_count
    puts "There are #{station.listeners_count} listeners on #{station.name}"
  end

  private

  def station
    @station ||= LiveStation.find(params[:station_id])
  end
end
