RSpec.describe 'POST /api/recipes', type: :request do
  subject { response }

  let!(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }

  describe 'as an authenticated user' do
    describe 'successfully' do
      before do
        post '/api/recipes', params: {
          recipe: {
            name: 'Fried rice with kimchi',
            instructions: 'Mix and shake it',
            ingredients: { name: 'Bacon', unit: 'gram', amount: '2000' }
          }
        }, headers: credentials
        @recipe = Recipe.last
      end

      it { is_expected.to have_http_status :created }

      it 'is expected to create an instance of a Recipe' do
        expect(@recipe).to_not eq nil
      end
      
      it 'is expected to have saved the recipe in the database' do
        expect(@recipe.name).to eq 'Fried rice with kimchi'
      end
      
      it 'is expected to respond with a confirmation message' do
        expect(response_json['message']).to eq 'Your recipe has been created'
      end
      
      it 'is expected to save recipe ingredients' do
        expect(@recipe.ingredients.length).to_not eq nil
        binding.pry
      end
    end

    describe 'unsuccessfully' do
      describe 'due to missing params' do
        before do
          post '/api/recipes', params: {}, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq 'Missing params'
        end
      end

      describe 'due to missing recipe name' do
        before do
          post '/api/recipes', params: {
            recipe: {
              instructions: 'Mix and shake it',
              ingredients: { name: 'Bacon', unit: 'gram', amount: '2000' }
            }
          }, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq 'Your recipe must have a name'
        end
      end

      describe 'due to missing recipe instructions' do
        before do
          post '/api/recipes', params: {
            recipe: {
              name: 'Spaghetti bolognese',
              ingredients: { name: 'Bacon', unit: 'gram', amount: '2000' }
            }
          }, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq 'Your recipe must have instructions'
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
          ingredients: { name: 'Bacon', unit: 'gram', amount: '2000' }
        }
      }, headers: nil
    end

    it { is_expected.to have_http_status :unauthorized }

    it 'is expected to respond with an error message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end
