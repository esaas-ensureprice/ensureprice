class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :ques, null: false
      t.integer :asked_by, null: false

      t.timestamps null: false
    end
  end
end
