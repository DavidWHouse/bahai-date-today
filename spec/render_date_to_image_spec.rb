require 'render_date_to_image'

describe RenderDateToImage do
  let(:renderer) { RenderDateToImage.new }

  it 'sets the date' do
    renderer.set_date(1, 1, 1)
    expect(renderer.date.to_s).to eq('1.1.1')
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

  it 'renders the html to a jpg' do
    renderer.html = '<html><body>Test</body></html>'
    result = renderer.render_html_to_image
    expect(result.size).to be > 1000
  end

  it 'performs all steps and returns the image' do
    expect(renderer).to receive(:set_date).with(1, 2, 3)
    expect(renderer).to receive(:load_template)
    expect(renderer).to receive(:render_template_to_html)
    expect(renderer).to receive(:render_html_to_image).and_return('image')
    result = renderer.perform(1, 2, 3)
    expect(result).to eq('image')
  end
end
