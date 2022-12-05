class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :ques
      t.integer :asked_by
      t.integer :upvotes

      t.timestamps null: false
    end
  end
end
