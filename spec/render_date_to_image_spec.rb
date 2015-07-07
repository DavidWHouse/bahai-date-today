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
end
