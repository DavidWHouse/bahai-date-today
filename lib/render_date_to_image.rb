require 'erb'
require 'imgkit'
require 'bahai_date'

class RenderDateToImage
  attr_accessor:date, :target_path, :template, :html

  TEMPLATE_PATH = 'app/assets/htmls/date.html.erb'

  def perform(year, month, day, rails_root)
    set_date(year, month, day)
    set_path(rails_root)
    load_template
    render_template_to_html
    render_html_to_image
  end

  def set_date(year, month, day)
    @date = BahaiDate::BahaiDate.new(year: year, month: month, day: day)
  end

  def set_path(rails_root)
    filename = "#{@date.to_s}.jpg"
    @target_path = Pathname.new(rails_root).join('tmp', filename).to_s
  end

  def load_template
    @template = File.read(TEMPLATE_PATH)
  end

  def render_template_to_html
    @html = ERB.new(@template).result binding
  end

  def render_html_to_image
    options = { 'height' => 506, 'width' => 968, 'quality' => 75 }
    kit = IMGKit.new(@html, options)
    kit.to_file(@target_path)
  end
end
