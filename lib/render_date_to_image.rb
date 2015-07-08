require 'erb'
require 'imgkit'
require 'bahai_date'

class RenderDateToImage
  attr_accessor :date, :rails_root, :target_path, :source_file, :template, :html

  TEMPLATE_PATH = 'lib/assets/htmls/date.html.erb'

  def initialize(date, rails_root)
    @date = date
    @rails_root = rails_root
  end

  def perform
    determine_target_path
    load_template
    render_template_to_html
    write_html_to_temp_file
    render_html_to_image
  end

  def determine_target_path
    filename = "#{@date}.jpg"
    @target_path = @rails_root.join('tmp', filename).to_s
  end

  def load_template
    @template = File.read(TEMPLATE_PATH)
  end

  def render_template_to_html
    @html = ERB.new(@template).result binding
  end

  def write_html_to_temp_file
    @source_file = Tempfile.new(%w(date .html))
    @source_file.write @html
    @source_file.flush
  end

  def render_html_to_image
    options = { 'height' => 506, 'width' => 968, 'quality' => 75 }
    kit = IMGKit.new(@source_file, options)
    kit.to_file(@target_path)
  end
end
