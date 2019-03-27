class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :sport_type
      t.string :athlete_id
    end
  end
end
