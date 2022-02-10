RSpec.describe 'POST /api/auth/sign_in', type: :request do
  subject { response }
  let(:user) { create(:user) }
  let(:expected_response) do
    {
      'data' => {
        'id' => user.id,
        'name' => user.name,
        'uid' => user.email,
        'email' => user.email,
        'provider' => 'email',
        'allow_password_change' => false
      }
    }
  end

  describe 'with valid credentials' do
    before do
      post '/api/auth/sign_in', params: {
        email: user.email,
        password: user.password
      }
    end

    it { is_expected.to have_http_status :ok }

    it 'is expected to respond with expected response' do
      expect(response_json).to eq expected_response
    end
  end

  describe 'with invalid credentials' do
    describe 'with invalid email' do
      before do
        post '/api/auth/sign_in', params: {
          email: 'not@mail.com',
          password: user.password
        }
      end

      it { is_expected.to have_http_status :unauthorized }

      it 'is expected to respond with expected response' do
        expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
      end
    end

    describe 'with invalid password' do
      before do
        post '/api/auth/sign_in', params: {
          email: user.email,
          password: 'wrong_pasword'
        }
      end

      it { is_expected.to have_http_status :unauthorized }

      it 'is expected to respond with expected response' do
        expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
      end
    end
  end
end
