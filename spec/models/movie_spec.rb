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

  describe ".all_ratings" do
    subject { Movie.all_ratings }

    it { should include 'G' }
    it { should include 'PG' }
    it { should include 'PG-13' }
    it { should include 'NC-17' }
    it { should include 'R' }
  end
end
