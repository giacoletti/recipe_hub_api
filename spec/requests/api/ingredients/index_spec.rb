RSpec.describe 'GET /api/ingredients', type: :request do
  subject { response }

  let!(:spaghetti) { create(:ingredient, name: 'Spaghetti') }
  let!(:egg) { create(:ingredient, name: 'Egg') }
  let!(:flour) { create(:ingredient, name: 'Flour') }

  describe 'successfully' do
    before do
      get '/api/ingredients'
    end

    it { is_expected.to have_http_status :ok }

    it 'is expected to respond with a collection of 3 ingredients' do
      expect(response_json['ingredients'].length).to eq 3
    end

    it 'is expected to respond with Spaghetti ingredient' do
      expect(response_json['ingredients'].select do |ingredient|
               ingredient['name'] == spaghetti.name
             end).to eq [{ 'id' => spaghetti.id, 'name' => spaghetti.name }]
    end
  end
end
