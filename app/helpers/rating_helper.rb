module RatingHelper
  def star_rating_class(rating, index)
    rating_diff = rating-index
    if rating_diff >= 0
      "fa fa-star checked"
    elsif rating_diff < 0 && rating_diff > -1
      "fa fa-star-half-o checked"
    else
      "fa fa-star unchecked"
    end 
  end
end