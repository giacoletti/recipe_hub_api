RSpec.describe 'GET/api/recipes/:id', type: :request do
  describe 'successfully' do
    let!(:ingredient1) do
      create(:ingredient, {
               "name": 'sugar'
             })
    end
    let!(:ingredient2) do
      create(:ingredient, {
               "name": 'milk'
             })
    end

    let!(:recipe) do
      create(
        :recipe,
        title: 'Pancakes',
        instructions: 'mix it together'
      )
    end

    let!(:ingredients_recipe) do
      create(:ingredients_recipe,
             recipe: recipe,
             ingredient: ingredient1)
    end
    before do
      get "/api/recipes/#{recipe.id}"
    end

    it 'is expected to return a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return the requested recipes title' do
      expect(response_json['recipe']['title']).to eq 'Pancakes'
    end

    it 'is expected to return the requested recipes ingredients' do
      expect(response_json['recipe']['ingredients']).to eq [{
        'amount' => 200.0, 'ingredient_id' => ingredient1.id, 'recipe_id' => recipe.id, 'unit' => 'grams'
      }]
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
