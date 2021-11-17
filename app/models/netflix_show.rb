# frozen_string_literal: true

require 'time'

class NetflixShow < ApplicationRecord
  validates :title, uniqueness: true

  scope :filter_by_country, ->(country) { where country: country }
  scope :filter_by_genre, ->(genre) { where show_type: genre }
  scope :filter_by_year, ->(year) { where release_year: year }

  def as_json(options = {})
    super(options)
    if date_added
      time = Time.parse(date_added)
      time_convert = time.strftime('%Y-%d-%m')
    else
      time_convert = date_added
    end

    {
      id: id,
      title: title,
      genre: show_type,
      year: release_year,
      country: country,
      published_at: time_convert,
      description: description
    }
  end
end
