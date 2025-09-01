require "rails_helper"

RSpec.describe "Subscriptions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/subscriptions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/subscriptions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/subscriptions/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
