class AddRatingToDoctorReviews < ActiveRecord::Migration
  def change
    add_column :doctor_reviews, :rating, :integer, null: false, default: 1
  end
end
