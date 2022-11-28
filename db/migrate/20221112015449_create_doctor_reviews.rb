class CreateDoctorReviews < ActiveRecord::Migration
  def change
    create_table :doctor_reviews do |t|
      t.integer :doctor_id
      t.string :doctor_name
      t.string :user_email
      t.string :user_name
      t.text :review_title
      t.text :user_review
      t.timestamps null: false
    end
  end
end
