class GetYoutubeIdServices
  def self.url_to_id(url)
    return url if url.blank?

    id_search = url.split('v=')[1]
    return url if id_search.nil?

    return id_search.slice(0, 11)
  end
end