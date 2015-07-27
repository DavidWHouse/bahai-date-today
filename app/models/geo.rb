require 'maxminddb'
require 'bahai_date'
require 'solareventcalculator'

class Geo
  # This product includes GeoLite2 data created by MaxMind, available from
  # <a href="http://www.maxmind.com">http://www.maxmind.com</a>.
  # http://dev.maxmind.com/geoip/geoip2/geolite2/
  # http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz
  MAXMIND_DATA_FILE = '/usr/share/GeoIP/GeoLite2-City.mmdb'

  attr_reader :ip, :latitude, :longitude, :city, :country, :time_zone,
    :current_time, :sunset_time_today, :current_date, :current_gregorian_date_in_bahai_calendar

  def initialize(ip)
    @ip = ip
    lookup_geo
    calculate_times_for_current_geo
  end

  def bahai_date
    BahaiDate::BahaiDate.new(date: @current_gregorian_date_in_bahai_calendar || Date.today)
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
      @current_time = get_current_time_in_time_zone
      @current_date = get_current_date
      @sunset_time_today = get_sunset_time_today
      @current_gregorian_date_in_bahai_calendar = get_current_gregorian_date_in_bahai_calendar
    end

    def get_current_time_in_time_zone
      Time.now.in_time_zone @time_zone
    end

    def get_current_date
      @current_time.to_date
    end

    def get_sunset_time_today
      calculator = SolarEventCalculator.new(@current_date, @latitude, @longitude)
      calculator.compute_official_sunset(@time_zone)
    end

    def get_current_gregorian_date_in_bahai_calendar
      return @current_date unless sunset_passed?
      @current_date + 1.day
    end

    def sunset_passed?
      @current_time > @sunset_time_today
    end
end
