require 'render_date_to_image'

class DateController < ApplicationController
  before_action :set_date

  def view
    respond_to do |format|
      format.html
      format.jpeg do
        set_header_and_send_file(RenderDateToImage.new(@date, Rails.root).perform)
      end
    end
  end

  def set_header_and_send_file(path)
    response.headers['Content-Length'] = File.size(path).to_s
    send_file path, type: 'image/jpeg', disposition: 'inline'
  end

  def set_date
    @date = BahaiDate::BahaiDate.new(year: params[:year], month: params[:month], day: params[:day])
  end
end
