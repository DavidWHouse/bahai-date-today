require 'bahai_date'

class HomeController < ApplicationController
  def index
    @date = BahaiDate::BahaiDate.new(date: Date.today)
  end
end
