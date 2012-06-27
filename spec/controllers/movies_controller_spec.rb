require 'spec_helper'

describe MoviesController do
  let!(:star_wars) { Movie.create title: 'Star Wars', director: 'George Lucas' }
  let!(:thx_1138) { Movie.create title: 'THX-1138', director: 'George Lucas' }
  let!(:alien) { Movie.create title: 'Alien' }

  describe "search for similar movies" do
    render_views

    context "with known director" do
      before(:each) { get :similar, id: star_wars.id }

      it "should render similar movies page" do
        response.should render_template('similar')
      end

      it "should list similar movies" do
        response.body.should =~ /<a.*>#{thx_1138.title}<\/a>/
      end

      it "should not list movie from other directors" do
        response.body.should_not =~ /<a.*>#{alien.title}<\/a>/
      end

      it "should not list movie itself" do
        response.body.should_not =~ /<a.*>#{star_wars.title}<\/a>/
      end
    end

    context "with unknown director" do
      before(:each) { get :similar, id: alien.id }

      it "should redirect to home page" do
        response.should redirect_to root_path
      end

      it "should flash no director info" do
        flash[:notice].should == "'#{alien.title}' has no director info"
      end
    end
  end
end
