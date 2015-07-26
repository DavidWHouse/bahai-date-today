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

  attr_reader :ip, :latitude, :longitude, :city, :country, :time_zone, :current_time, :sunset_time_today, :current_date

  def initialize(ip)
    @ip = ip
    lookup_geo
    calculate_times_for_current_geo
  end

  def bahai_date
    BahaiDate::BahaiDate.new(date: @current_date)
  end

  private

    def lookup_geo
      db = MaxMindDB.new(MAXMIND_DATA_FILE)
      results = db.lookup(@ip)
      @latitude = results.location.latitude
      @longitude = results.location.longitude
      @city = results.city.name
      @country = results.country.name
      @time_zone = results.location.time_zone
    end

    def calculate_times_for_current_geo
      @current_time = get_current_time + 5.hours
      @sunset_time_today = get_sunset_time_today
      @current_date = get_current_date
    end

    def get_current_time
      return Time.now unless @time_zone
      Time.now.in_time_zone @time_zone
    end

    def get_sunset_time_today
      return @current_time unless @time_zone && @latitude && @longitude
      calculator = SolarEventCalculator.new(@current_time.to_date, @latitude, @longitude)
      calculator.compute_utc_solar_event(AZIMUTH, false).in_time_zone(@time_zone)
    end

    def get_current_date
      current_date = @current_time.to_date
      return current_date unless @latitude && @longitude
      return current_date unless sunset_passed?
      current_date + 1.day
    end

    def sunset_passed?
      @current_time > @sunset_time_today
    end
end
