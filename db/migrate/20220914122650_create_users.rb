class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.text :bio
      t.string :photo, null: false, 'https://api.lorem.space/image/fashion?w=150&h=150&t=1'
      t.integer :posts_counter, null: false, default: 0

      t.timestamps
    end
  end
end
