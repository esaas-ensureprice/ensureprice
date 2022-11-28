module RatingHelper
  def star_rating_class(rating, index)
    rating_diff = rating-index
    if rating_diff >= 0
      puts("one star")
      "fa fa-star checked"
    elsif rating_diff < 0 && rating_diff > -1
      puts("half star")
      "fa fa-star-half-o checked"
    else
      puts("zero star")
      "fa fa-star unchecked"
    end 
  end
end