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
        response.should redirect_to movies_path
      end

      it "should flash no director info" do
        flash[:notice].should == "'#{alien.title}' has no director info"
      end
    end
  end

  describe "create a movie" do
    it "should add one movie to movies table" do
      expect { post :create, movie: { title: 'Iron Man' } }.to change { Movie.count }.by(1)
    end

    it "should redirect to movies page" do
      post :create, movie: { title: 'Iron Man' }
      response.should redirect_to movies_path
    end

    it "should flash movie was successfully created" do
      post :create, movie: { title: 'Iron Man' }
      flash[:notice].should == 'Iron Man was successfully created.'
    end
  end

  describe "delete a movie" do
    it "should remove one movie from movies table" do
      expect { delete :destroy, id: alien.id }.to change { Movie.count }.by(-1)
    end

    it "should redirect to movies page" do
      delete :destroy, id: alien.id
      response.should redirect_to movies_path
    end

    it "should flash movie created" do
      delete :destroy, id: alien.id
      flash[:notice].should == "Movie '#{alien.title}' deleted."
    end
  end

  describe "edit a movie" do
    before(:each) { get :edit, id: star_wars.id }

    it "should assign @movie" do
      assigns(:movie).should eq star_wars
    end

    it "should render edit movie template" do
      response.should render_template('edit')
    end
  end

  describe "update a movie info" do
    let!(:new_title) { 'Star Wars II' }

    before(:each) { post :update, id: star_wars.id, movie: { title: new_title } }

    it "should have new info" do
      Movie.find(star_wars.id).title.should == new_title
    end

    it "should redirect to the movie detail page" do
      response.should redirect_to movie_path
    end

    it "should flash movie was successfully updated" do
      flash[:notice].should == "#{new_title} was successfully updated."
    end
  end
end
