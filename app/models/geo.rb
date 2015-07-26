require 'maxminddb'
require 'bahai_date'
require 'solareventcalculator'

class Geo
  # source: http://www.timeanddate.com/astronomy/about-sun-calculator.html
  # Technically, sunrise and sunset are calculated based on the true geocentric position of the Sun at 90°50' from the zenith position (directly above the observer).
  AZIMUTH = 90.83

  # This product includes GeoLite2 data created by MaxMind, available from
  # <a href="http://www.maxmind.com">http://www.maxmind.com</a>.
  # http://dev.maxmind.com/geoip/geoip2/geolite2/
  # http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz
  MAXMIND_DATA_FILE = '/usr/share/GeoIP/GeoLite2-City.mmdb'

  attr_reader :latitude, :longitude, :city, :country

  def initialize(ip)
    @ip = ip
    lookup_geo
  end

  def bahai_date
    BahaiDate::BahaiDate.new(date: today)
  end

  private

    def lookup_geo
      db = MaxMindDB.new(MAXMIND_DATA_FILE)
      results = db.lookup(@ip)
      @latitude = results.location.latitude
      @longitude = results.location.longitude
      @city = results.city.name
      @country = results.country.name
    end

    def today
      return Date.today unless @latitude && @longitude
      return Date.today unless sunset_passed?
      Date.tomorrow
    end

    def sunset_today
      calculator = SolarEventCalculator.new(Time.now, @latitude, @longitude)
      calculator.compute_utc_solar_event(AZIMUTH, false)
    end

    def sunset_passed?
      Time.now > sunset_today
    end
end
