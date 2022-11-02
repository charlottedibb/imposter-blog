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
    let(:article) { FactoryBot.create(:article) }

    context "is valid" do
      it "should respond with 200 for an existing article" do
        get :show, params: { id: article.id }
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end

      it "should render the show template" do
        get :show, params: { id: article.id }
        expect(response).to render_template(:show)
      end
    end

    context "is invalid" do
      it "should respond with 404 for a nonexistent article" do
        get :show, params: { id: 100 }
        aggregate_failures do
          expect(response).to_not be_successful
          expect(response).to have_http_status "404"
        end
      end
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
    let(:valid_params) { FactoryBot.attributes_for(:article) }

    context "is valid" do
      it "should create an article when given correct params" do
        expect {
          post :create, params: { article: valid_params }
        }.to change(Article, :count).by(1)
      end

      it "should redirect to the articles page" do
        post :create, params: { article: valid_params }
        assert_redirected_to articles_url
      end
    end

    context "is invalid" do
      it "should not create an article when given incorrect params" do
        expect {
          post :create, params: { article: { title: valid_params[:title], body: nil } }
        }.to_not change(Article, :count)
      end

      it "should render the new template" do
        post :create, params: { article: { title: valid_params[:title], body: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#edit" do
    let(:article) { FactoryBot.create(:article) }

    context "is valid" do
      it "should respond with 200 for an existing article" do
        get :edit, params: { id: article.id }
        aggregate_failures do
          expect(response).to be_successful
          expect(response).to have_http_status "200"
        end
      end

      it "should render the edit template" do
        get :edit, params: { id: article.id }
        expect(response).to render_template(:edit)
      end
    end

    context "is invalid" do
      it "should respond with 404 for a nonexistent article" do
        get :edit, params: { id: 100 }
        aggregate_failures do
          expect(response).to_not be_successful
          expect(response).to have_http_status "404"
        end
      end
    end
  end

  describe "#update" do
    let(:article) { FactoryBot.create(:article) }

    context "is valid" do
      let(:article_params) { FactoryBot.attributes_for(:article, title: "New title") }

      it "should have status 302" do
        patch :update, params: { id: article.id, article: article_params }
        expect(response).to have_http_status "302"
      end

      it "should have a new title" do
        patch :update, params: { id: article.id, article: article_params }
        expect(article.reload.title).to eq(article_params[:title])
      end

      it "should redirect after successfully updating an article" do
        patch :update, params: { id: article.id, article: article_params }
        assert_redirected_to articles_url
      end
    end

    context "is invalid" do
      it "should not edit an article" do
        patch :update, params: { id: article.id, article: { title: nil } }
        expect(article.reload.title).to_not eq(nil)
      end

      it "should have status 422" do
        patch :update, params: { id: article.id, article: { title: nil } }
        expect(response).to have_http_status "422"
      end

      it "should render the edit template" do
        patch :update, params: { id: article.id, article: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do
    let!(:article) { FactoryBot.create(:article) }
    
    context "is valid" do
      it "should delete an article with a valid id" do
        expect {
          delete :destroy, params: { id: article.id }
        }.to change(Article, :count).by(-1)
      end

      it "should have status 302" do
        delete :destroy, params: { id: article.id }
        expect(response).to have_http_status "302"
      end

      it "should redirect to articles page" do
        delete :destroy, params: { id: article.id }
        assert_redirected_to articles_url
      end
    end

    context "is invalid" do
      it "should not delete an article with an invalid id" do
        expect {
          delete :destroy, params: { id: 21902371 }
        }.to_not change(Article, :count)
        expect(response).to have_http_status "404"
      end
    end
  end
end
