RSpec.describe 'GET/api/recipes/:id', type: :request do
  describe 'successfully' do
    let!(:ingredient1) {  create(:ingredient, { name: 'sugar' }) }
    let!(:ingredient2) { create(:ingredient, { name: 'milk' }) }
    let!(:recipe) { create(:recipe, name: 'Pancakes', instructions: 'Mix it together') }

    let!(:ingredients_recipe) do
      create(:recipe_ingredient, recipe: recipe, ingredient: ingredient1)
      create(:recipe_ingredient, recipe: recipe, ingredient: ingredient2, amount: 6, unit: 'dl')
    end

    before do
      get "/api/recipes/#{recipe.id}"
    end

    it 'is expected to return a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return the requested recipe name' do
      expect(response_json['recipe']['name']).to eq 'Pancakes'
    end

    it 'is expected to return the requested recipe instructions' do
      expect(response_json['recipe']['instructions']).to eq 'Mix it together'
    end

    it 'is expected to return the requested recipe ingredients' do
      expected_response = [{ 'name' => 'sugar', 'amount' => 200.0, 'unit' => 'grams' },
                           { 'name' => 'milk', 'amount' => 6.0, 'unit' => 'dl' }]
      expect(response_json['recipe']['ingredients']).to eq expected_response
    end
  end

  describe 'unsuccessfully - id not found' do
    before do
      get '/api/recipes/wrong_id'
    end

    it 'is expected to return a 404 status' do
      expect(response).to have_http_status 404
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'Recipe not found'
    end
  end
end
