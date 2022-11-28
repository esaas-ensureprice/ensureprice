module RatingHelper
  def star_rating_class(review, index)
    if index <= review.rating
      "checked"
    else
      "unchecked"
    end
  end
end