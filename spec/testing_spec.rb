require 'rails_helper.rb'

describe Rails do
  it "should return 2 for 1 + 1" do
    sum=1+1
    expect(sum).to eq(2)
  end
end