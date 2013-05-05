module AdminHelper
  def tick_to_time(ticks)
    return [0,0] if ticks <= 0
    hours = ticks / 1000 + 6
    minutes = (ticks % 1000) * 60 / 1000
    return [hours, minutes]
  end
end
