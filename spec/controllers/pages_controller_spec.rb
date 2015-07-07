require 'rails_helper'

describe HighVoltage::PagesController, '#show' do
  %w(about bahai-calendar).each do |page|
    context "on GET to /#{page}" do
      before do
        get :show, id: page
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(response).to render_template(page) }
    end
  end
end
