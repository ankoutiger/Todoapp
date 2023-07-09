class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false
      t.string :title,null: false
      t.text :content, null: false
      # t.times :limit,null: false
      t.timestamps
    end
  end
end
