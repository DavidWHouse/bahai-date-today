require 'bahai_date'

class HomeController < ApplicationController
  def index
    @geo = Geo.new(request.remote_ip)
    @date = @geo.bahai_date
  end
end
