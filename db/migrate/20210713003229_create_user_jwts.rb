class CreateUserJwts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_jwts do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
