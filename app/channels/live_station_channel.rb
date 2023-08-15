class LiveStationChannel < ApplicationChannel
  delegate :broadcast_replace_to, to: :"Turbo::StreamsChannel"

  def subscribed
    stream_for station

    station.increment_listeners_count
    broadcast_replace_to station, target: dom_id(station, :listeners_count), partial: "player/listeners_count", locals: {station: station}
  end

  def unsubscribed
    station.decrement_listeners_count
    broadcast_replace_to station, target: dom_id(station, :listeners_count), partial: "player/listeners_count", locals: {station: station}
  end

  private

  def station
    @station ||= LiveStation.find(params[:station_id])
  end
end
