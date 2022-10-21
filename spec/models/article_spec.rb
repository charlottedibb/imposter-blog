require 'rails_helper'

describe Article, type: :model do
  it "is valid with all of it's parameters" do
    article = Article.new(title: 'Hello', body: 'World', author: 'Daniel Ricciardo')
    expect(article).to be_valid
  end
  it "is valid with only required parameters" do
    article = Article.new(title: 'Hello', body: 'World')
    expect(article).to be_valid
  end
  it "is invalid without required parameters" do
    article = Article.new(title: 'Hello')
    expect(article).to_not be_valid
  end

  it "parameter is unique" do
    article = Article.create(title: 'Hello', body: 'World')
    article2 = Article.create(title: 'Hello', body: 'World')
    article2.valid?

    expect(article2).to_not be_valid
    expect(article2.errors[:title]).to include("has already been taken")
  end
end