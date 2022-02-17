RSpec.describe 'POST /api/recipes', type: :request do
  subject { response }

  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:rice) { create(:ingredient, name: 'Rice') }
  let!(:kimchi) { create(:ingredient, name: 'Kimchi') }
  let!(:original_recipe) { create(:recipe, user: user) }
  let(:new_user) { create(:user, name: 'Elvita') }
  let(:new_credentials) { new_user.create_new_auth_token }

  describe 'as an authenticated user' do
    describe 'successfully' do
      before do
        post '/api/recipes', params: {
          recipe: {
            name: 'Fried rice with kimchi',
            instructions: 'Mix and shake it',
            ingredients_attributes: [
              { ingredient_id: rice.id, unit: 'gram', amount: '2000' },
              { ingredient_id: kimchi.id, unit: 'gram', amount: '2000' }
            ],
            image: 'data:image/image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAAEBCAMAAAD1kWivAAADAFB'
          }
        }, headers: credentials
        @recipe = Recipe.last
      end

      it { is_expected.to have_http_status :created }

      it 'is expected to create an instance of a Recipe' do
        expect(@recipe).to_not eq nil
      end

      it 'is expected to attach the image' do
        expect(@recipe.image).to be_attached
      end

      it 'is expected to have saved the recipe in the database' do
        expect(@recipe.name).to eq 'Fried rice with kimchi'
      end

      it 'is expected to respond with a confirmation message' do
        expect(response_json['message']).to eq 'Your recipe has been created'
      end

      it 'is expected to have saved the recipe with the user associated' do
        expect(@recipe.user.name).to eq user.name
      end

      it 'is expected to associate recipe with ingredients' do
        expect(@recipe.ingredients.size).to eq 2
      end

      describe 'can fork a recipe' do
        before do
          post '/api/recipes', params: {
            recipe: {
              id: original_recipe.id,
              fork: true
            }
          }, headers: new_credentials
          @recipe = Recipe.find(original_recipe.id)
        end

        it { is_expected.to have_http_status :created }

        it 'is expected to respond with a success message' do
          expect(response_json['message']).to eq 'The recipe was successfully forked and saved in your collection'
        end

        it 'is expected to have original recipe forks count up to 1' do
          expect(@recipe.forks_count).to eq 1
        end
      end
    end

    describe 'unsuccessfully' do
      describe 'due to missing params' do
        before do
          post '/api/recipes', params: {}, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq 'Recipe is missing'
        end
      end

      describe 'due to missing recipe name' do
        before do
          post '/api/recipes', params: {
            recipe: {
              instructions: 'Mix and shake it',
              ingredients_attributes: [
                { ingredient_id: rice.id, unit: 'gram', amount: '2000' }
              ]
            }
          }, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq "Name can't be blank"
        end
      end

      describe 'due to missing recipe instructions' do
        before do
          post '/api/recipes', params: {
            recipe: {
              name: 'Spaghetti bolognese',
              ingredients_attributes: [
                { ingredient_id: rice.id, unit: 'gram', amount: '2000' }
              ]
            }
          }, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq "Instructions can't be blank"
        end
      end

      describe 'cannot fork recipe due to invalid id' do
        before do
          post '/api/recipes', params: {
            recipe: {
              id: 'AODHSAJOSDA',
              fork: true
            }
          }, headers: new_credentials
        end

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq 'Recipe not found'
        end
      end
    end
  end

  describe 'as anonymous user' do
    before do
      post '/api/recipes', params: {
        recipe: {
          name: 'Pasta Carbonara',
          instructions: 'Mix and shake it',
          ingredients_attributes: [
            { ingredient_id: rice.id, unit: 'gram', amount: '2000' }
          ]
        }
      }, headers: nil
    end

    it { is_expected.to have_http_status :unauthorized }

    it 'is expected to respond with an error message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end
