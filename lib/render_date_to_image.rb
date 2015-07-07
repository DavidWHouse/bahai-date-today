require 'erb'
require 'imgkit'
require 'bahai_date'

class RenderDateToImage
  attr_accessor :date, :rails_root, :target_path, :template, :html

  TEMPLATE_PATH = 'app/assets/htmls/date.html.erb'
  STYLESHEET_PATH = 'app/assets/stylesheets/date.css'

  def initialize(date, rails_root)
    @date = date
    @rails_root = rails_root
  end

  def perform
    determine_target_path
    load_template
    render_template_to_html
    render_html_to_image
  end

  def determine_target_path
    filename = "#{@date.to_s}.jpg"
    @target_path = @rails_root.join('tmp', filename).to_s
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
    kit.stylesheets << STYLESHEET_PATH
    kit.to_file(@target_path)
  end
end
