module NotesHelper
  def timecode(seconds)
    min = "%02d" % (seconds / 60).floor
    sec = "%02d" % (seconds % 60)
    return "#{min}:#{sec}"
  end
end
