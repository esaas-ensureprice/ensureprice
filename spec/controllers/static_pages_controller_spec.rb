require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do
  describe "GET #home" do
    it "should return http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET #about" do
    it "should return http success" do
      get 'about'
      response.should be_success
    end
  end
end