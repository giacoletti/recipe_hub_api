RSpec.describe 'POST /api/recipes/:id/comments', type: :request do
  subject { response }

  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:recipe) { create(:recipe) }

  describe 'As an authenticated user' do
    describe 'successfully' do
      before do
        post "/api/recipes/#{recipe.id}/comments",
             params: { comment: { body: 'Awesome recipe' } }, headers: credentials
        @comment = Comment.last
      end

      it { is_expected.to have_http_status :created }

      it 'is expected to create an instance of a comment' do
        expect(@comment).to_not eq nil
      end

      it 'is expected to save a comment in database' do
        expect(@comment.body).to eq 'Awesome recipe'
      end

      it 'is expected to respond with the saved comment' do
        expect(response_json['comment']['body']).to_eq 'Awesome recipe'
      end
    end
  end
end
