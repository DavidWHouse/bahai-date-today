require 'erb'
require 'bahai_date'

class RenderDateToImage
  attr_accessor:date, :template, :html

  TEMPLATE_PATH = 'app/assets/htmls/date.html.erb'

  def perform(year, month, day)
    set_date(year, month, day)
    load_template
    render_template_to_html
  end

  def set_date(year, month, day)
    @date = BahaiDate::BahaiDate.new(year: year, month: month, day: day)
  end

  def load_template
    @template = File.read(TEMPLATE_PATH)
  end

  def render_template_to_html
    @html = ERB.new(@template).result binding
  end
end
