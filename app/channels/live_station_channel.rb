class LiveStationChannel < ApplicationChannel
  delegate :broadcast_replace_to, to: :"self.class"

  after_subscribe :increment_listeners_count
  after_unsubscribe :decrement_listeners_count

  private

  def increment_listeners_count
    station.increment_listeners_count
    broadcast_replace_to station, target: dom_id(station, :listeners_count), partial: "player/listeners_count", locals: {station: station}
  end

  def decrement_listeners_count
    station.decrement_listeners_count
    broadcast_replace_to station, target: dom_id(station, :listeners_count), partial: "player/listeners_count", locals: {station: station}
  end

  def station
    @station ||= LiveStation.find(params[:station_id])
  end
end
