class Time
  class << self
    def ensure_zone(date)
      d = Date._parse(date, false)
      !d[:zone].nil?
    end
  end
end
