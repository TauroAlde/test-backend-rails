class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.boolean :star
      t.integer :repo_id
      t.timestamps
      t.belongs_to :user, foreign_key: true
    end
  end
end
