require "rails_helper"

RSpec.describe ArticlesController, type: :controller do
  describe "#index" do
    it "should repond with 200" do
      aggregate_failures do
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    it "should render the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#show" do
    before do
      @article = Article.create(title: "Article Title", body: "Article Body")
    end

    it "should respond with 200 for an existing article" do
      get :show, params: { id: @article.id }
      aggregate_failures do
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    it "should respond with 404 for a nonexistent article" do
      get :show, params: { id: 100 }
      expect(response).to_not be_successful
      expect(response).to have_http_status "404"
    end

    it "should render the show template" do
      get :show, params: { id: @article.id }
      expect(response).to render_template(:show)
    end
  end

  describe "#new" do
    it "should assign a new article as @article" do
      get :new
      expect(assigns(:article)).to_not eq nil
      expect(assigns(:article)).to be_a_new(Article)
    end

    it "should render the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    let(:valid_params) {
      { title: "Article Title", body: "Article body" }
    }

    it "should create an article when given correct params" do
      expect {
        post :create, params: { article: valid_params }
      }.to change(Article, :count).by(1)

      assert_redirected_to articles_url
    end

    it "should not article when given incorrect params" do
      expect {
        post :create, params: { article: { title: "article title ", body: nil } }
      }.to_not change(Article, :count)

      expect(response).to render_template(:new)
    end
  end

  describe "#edit" do
    before do
      @article = Article.create(title: "Article Title", body: "Article Body")
    end

    it "should respond with 200 for an existing article" do
      get :edit, params: { id: @article.id }
      aggregate_failures do
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end

    it "should respond with 404 for a nonexistent article" do
      get :edit, params: { id: 100 }
      expect(response).to_not be_successful
      expect(response).to have_http_status "404"
    end

    it "should render the show template" do
      get :edit, params: { id: @article.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    before do
      @article = Article.create(title: "Article Title", body: "Article Body")
    end
    it "should edit an article with valid params" do
      patch :update, params: { id: @article.id, article: { title: "New Title" } }
      expect(response).to have_http_status "302"
      assert_redirected_to articles_url
    end

    it "should not edit an article with invalid params" do
      patch :update, params: { id: @article.id, article: { title: nil } }
      expect(response).to have_http_status "422"
      expect(response).to render_template(:edit)
    end
  end

  describe "#destroy" do
    before do
      @article = Article.create(title: "Article Title", body: "Article Body")
    end

    it "should delete an article with a valid id" do
      expect {
        delete :destroy, params: { id: @article.id }
      }.to change(Article, :count).by(-1)
      expect(response).to have_http_status "302"
      assert_redirected_to articles_url
    end

    it "should not delete an article with an invalid id" do
      expect {
        delete :destroy, params: { id: 21902371 }
      }.to_not change(Article, :count)
      expect(response).to have_http_status "404"
    end
  end
end
