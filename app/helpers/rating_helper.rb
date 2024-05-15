module RatingHelper
  def star_rating_class(order, index)
    if index < order.rating
      "fill-yellow-400 stroke-yellow-400"
    else
      "fill-transparent stroke-gray-400"
    end
  end
end
