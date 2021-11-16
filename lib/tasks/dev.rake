require 'csv'

namespace :dev do
  desc "Apaga, cria, migra e popula o BD"
  task feed_bd: :environment do
    %x(rails db:drop db:create db:migrate)
    path = Rails.root.join('lib', 'tasks', 'netflix_titles.csv')
    CSV.foreach(path, :headers => true, encoding: "UTF-8") do |row|
      NetflixShow.create(row.to_hash)
    end
  end

end
