require 'spec_helper'

describe Movie do
  describe "find similar movies" do
    let!(:star_wars) { Movie.create title: 'Star Wars', director: 'George Lucas' }
    let!(:thx_1138) { Movie.create title: 'THX-1138', director: 'George Lucas' }
    let!(:alien) { Movie.create title: 'Alien' }

    it "should find movies with same director" do
      star_wars.similar.should include thx_1138
    end

    it "should not list other director's movie" do
      star_wars.similar.should_not include alien
    end

    it "should not include itself in similar movies list" do
      star_wars.similar.should_not include star_wars
    end
  end
end
