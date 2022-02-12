RSpec.describe 'GET /api/ingredients', type: :request do
  subject { response }

  let!(:ingredients) { create_list(:ingredient, 20) }

  describe 'successfully' do
    before do
      get '/api/ingredients'
    end

    it { is_expected.to have_http_status :ok }

    it 'is expected to respond with a collection of 20 ingredients' do
      expect(response_json['ingredients'].count).to eq 20
    end
  end
end
