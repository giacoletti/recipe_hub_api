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

    it { is_expected.to have_http_status 200 }

    it 'is expected to respond with expected response' do
      expect(response_json).to eq expected_response
    end
  end
end
