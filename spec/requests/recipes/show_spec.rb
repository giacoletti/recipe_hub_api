RSpec.describe 'GET/api/recipes/:id', type: :request do
  describe 'successfully' do
    let!(:ingredient1) do
      create(:ingredient, {
               "amount": 100,
               "unit": 'grams',
               "name": 'sugar'
             })
    end
    let!(:ingredient2) do
      create(:ingredient, {
               "amount": 400,
               "unit": 'ml',
               "name": 'milk'
             })
    end

    let!(:recipe) do
      create(
        :recipe,
        title: 'Pancakes',
        ingredients: [ingredient1, ingredient2],
        instructions: 'mix it together'
      )
    end

    before do
      get "/api/recipes/#{recipe.id}"
    end

    it { is_expected.to have_http_status :ok }

    it 'is expected to return the requested recipes title' do
      expect(response_json['recipe']['title']).to eq 'Pancakes'
    end

    it 'is expected to return the requested recipes ingredients' do
      expect(response_json['recipe']['ingredients']).to eq [{
        'amount' => 100, 'unit' => 'grams', 'name' => 'sugar'
      }, { 'amount' => 400, 'name' => 'milk', 'unit' => 'ml' }]
    end
  end
end
