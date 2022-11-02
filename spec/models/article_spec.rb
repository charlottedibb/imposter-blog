require "rails_helper"

describe Article, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:article)).to be_valid
  end
  it "is valid with all of it's parameters" do
    article = Article.new(title: "Hello", body: "World", author: "Daniel Ricciardo")
    expect(article).to be_valid
  end
  it "is valid with factory parameters" do
    article = FactoryBot.build(:article)
    expect(article).to be_valid
  end
  it "is valid with only required parameters" do
    article = FactoryBot.build(:article, author: nil)
    expect(article).to be_valid
  end
  it "is invalid without required parameters" do
    article = FactoryBot.build(:article, body: nil)
    expect(article).to_not be_valid
  end

  it "is invalid without title parameter s" do
    article = FactoryBot.create(:article, title: "Hello")
    article2 = FactoryBot.build(:article, title: "Hello")
    article2.valid?

    expect(article2).to_not be_valid
    expect(article2.errors[:title]).to include("has already been taken")
  end
end
