class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def similar
    Movie.where "director=? AND id<>?", self.director, self.id
  end
end
