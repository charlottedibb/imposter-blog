require "rails_helper"

RSpec.describe ArticlesController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      aggregate_failures do
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#show" do
    before do
      @article = Article.create(title: "Article Title", body: "Article Body")
    end

    it "responds with 200 status for an existing article" do
      get :show, params: { id: @article.id }
      aggregate_failures do
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    it "responds with 404 for nonexistent article" do
      get :show, params: { id: 100 }
      expect(response).to have_http_status "404"
    end

    it "renders the :show template" do
      get :show, params: { id: @article.id }
      expect(response).to render_template(:show)
    end
  end

  describe "#new" do
  end
  describe "#create" do
  end
  describe "#edit" do
  end
  describe "#update" do
  end
  describe "#destroy" do
  end
end
