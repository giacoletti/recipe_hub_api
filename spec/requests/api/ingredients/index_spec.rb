RSpec.describe 'GET /api/ingredients', type: :request do
  subject { response }

  let!(:ingredient) { create(:ingredient) }

  describe 'successfully' do
    before do
      get '/api/ingredients'
    end

    it { is_expected.to have_http_status :ok }

    it 'is expected to respond with a collection of 1 ingredient' do
      expect(response_json['ingredients'].count).to eq 1
    end
  end
end
