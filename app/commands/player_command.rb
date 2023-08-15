class PlayerCommand < ApplicationCommand
  prevent_controller_action

  def play
    track_id = element.data.track
    track = Track.find(track_id)

    if current_user&.live_station&.live?
      station = current_user.live_station
      station.play_now(track)

      Turbo::StreamsChannel.broadcast_update_to station, target: :player, partial: "player/player", locals: {station:, track:}

      turbo_stream.update("player", partial: "player/player", locals: {station:, track:, live: true})
      turbo_stream.update(dom_id(station, :queue), partial: "live_stations/queue", locals: {station:})
    else
      turbo_stream.update("player", partial: "player/player", locals: {track:})
    end
  end

  def pause
    station = current_user.live_station
    track = station.current_track

    turbo_stream.update("player", partial: "player/player", locals: {track:, station:, live: false})
  end

  def resume
    station = current_user.live_station
    track = station.current_track

    turbo_stream.update("player", partial: "player/player", locals: {track:, station:, live: true})
  end
end
