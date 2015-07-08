require 'render_date_to_image'

describe RenderDateToImage do
  let(:renderer) { RenderDateToImage.new('date', 'path') }

  it 'sets the date' do
    expect(renderer.date).to eq('date')
  end

  it 'sets the rails root path' do
    expect(renderer.rails_root).to eq('path')
  end

  it 'determines the target path' do
    renderer.rails_root = Pathname.new('root')
    renderer.determine_target_path
    expect(renderer.target_path).to eq('root/tmp/date.jpg')
  end

  it 'loads the template' do
    renderer.load_template
    expect(renderer.template).to include('div')
  end

  it 'renders the template to html' do
    renderer.date = 'something'
    renderer.template = '<%= @date %>'
    renderer.render_template_to_html
    expect(renderer.html).to eq('something')
  end

  it 'writes the html to a temp file' do
    renderer.html = 'test'
    renderer.write_html_to_temp_file
    expect(File.read(renderer.source_file.path)).to eq('test')
  end

  it 'renders the html to a jpg' do
    source_file = Tempfile.new(%w(rspec .html))
    source_file.write '<html><body>Test</body></html>'
    source_file.flush
    renderer.source_file = source_file
    target_file = Tempfile.new(%w(rspec .jpg))
    renderer.target_path = target_file.path
    result = renderer.render_html_to_image
    expect(File.read(result).size).to be > 1000
  end

  it 'performs all steps and returns the image' do
    expect(renderer).to receive(:determine_target_path)
    expect(renderer).to receive(:load_template)
    expect(renderer).to receive(:render_template_to_html)
    expect(renderer).to receive(:write_html_to_temp_file)
    expect(renderer).to receive(:render_html_to_image).and_return('image_path')
    result = renderer.perform
    expect(result).to eq('image_path')
  end
end
