
require 'time'

class NetflixShow < ApplicationRecord
   validates :title, uniqueness: true

   scope :filter_by_country, -> (country) {where country: country}
   scope :filter_by_genre, -> (genre) {where show_type: genre}
   scope :filter_by_year, -> (year) {where release_year: year}

   def as_json(options={})
      super(options)
      if self.date_added
         time = Time.parse(self.date_added)
         time_convert = time.strftime("%Y-%d-%m")
      else 
         time = self.date_added
      end
      
      {
         id: self.id,
         title: self.title,
         genre: self.show_type,
         year: self.release_year,
         country: self.country,
         published_at: time_convert,
         description: self.description
      }
   end
end
