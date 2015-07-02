require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  describe 'GET /accounts' do
    it 'Account index' do
      get accounts_path
      expect(response).to have_http_status(302)
    end
  end
end
