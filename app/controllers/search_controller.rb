class SearchController < ApplicationController
  def index
    q = params[:q]

    if q.blank? || q.length < 3
      if turbo_frame_request? && turbo_frame_request_id.include?("nav--search--results")
        return render partial: "shared/nav_search_results"
      else
        return redirect_back(fallback_location: root_path, alert: "Please, enter at least 3 characters")
      end
    end

    @artists = Artist.search(q).limit(10)
    @albums = Album.search(q).limit(10)
    @tracks = Track.search(q).limit(10)

    if turbo_frame_request? && turbo_frame_request_id.include?("nav--search--results")
      render partial: "shared/nav_search_results", locals: {artists: @artists, albums: @albums, tracks: @tracks}
    else
      render :index
    end
  end
end
