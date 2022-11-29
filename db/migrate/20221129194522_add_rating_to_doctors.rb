class AddRatingToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :rating, :integer
  end
end
