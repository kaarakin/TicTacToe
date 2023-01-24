require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET /' do
    before { get root_path }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'responds with html' do
      expect(response.content_type).to match(%r{text/html})
    end
  end

  describe "GET /sign_in" do
    it "returns http success" do
      get "/users/sign_in"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sign_up" do
    it "returns http success" do
      get "/users/sign_in"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end
  
end