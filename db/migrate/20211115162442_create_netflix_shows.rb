# frozen_string_literal: true

class CreateNetflixShows < ActiveRecord::Migration[6.1]
  def change
    create_table :netflix_shows do |t|
      t.string :show_id
      t.string :show_type
      t.string :title
      t.string :director
      t.string :cast
      t.string :country
      t.string :date_added
      t.string :release_year
      t.string :rating
      t.string :duration
      t.string :listed_in
      t.text :description

      t.timestamps
    end
  end
end
