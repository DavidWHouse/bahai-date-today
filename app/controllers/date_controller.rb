require 'render_date_to_image'

class DateController < ApplicationController
  before_action :set_date

  def view
    respond_to do |format|
      format.html
      format.jpeg do
        send_file RenderDateToImage.new(@date, Rails.root).perform, type: 'image/jpeg', disposition: 'inline'
      end
    end
  end

  def set_date
    @date = BahaiDate::BahaiDate.new(year: params[:year], month: params[:month], day: params[:day])
  end
end
