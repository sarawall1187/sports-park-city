class CreateAthletesTable < ActiveRecord::Migration[4.2]

  def change
    create_table :athletes do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :age
      t.string :weight
      t.string :height
      t.string :achievement
    end
  end
end
