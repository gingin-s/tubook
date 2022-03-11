module NotesHelper
  def timecode(seconds)
    min = '%02d' % (seconds / 60).floor
    sec = format('%02d', (seconds % 60))
    "#{min}:#{sec}"
  end
end
