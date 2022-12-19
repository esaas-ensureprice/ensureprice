require 'rails_helper'

describe RatingHelper do
  describe "star_rating_class" do
    let!(:user) { FactoryBot.create(:user) }

    it 'returns the right action' do
      expect(star_rating_class(nil, 1)).to match("fa fa-star unchecked")
      expect(star_rating_class(2, 1)).to match("fa fa-star checked")
      expect(star_rating_class(0.5, 1)).to match("fa fa-star-half-o checked")
      expect(star_rating_class(-2, -1)).to match("fa fa-star unchecked")
    end
  end
end