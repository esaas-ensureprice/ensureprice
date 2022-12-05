class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.string :answer
      t.integer :answered_by

      t.timestamps null: false
    end
  end
end
