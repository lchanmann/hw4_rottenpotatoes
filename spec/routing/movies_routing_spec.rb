require 'spec_helper'

describe "Movies routing" do
  it "should route to /movies/1/similar" do
    get('/movies/1/similar').
      should route_to(
        controller: 'movies',
        action: 'similar',
        id: '1'
      )
  end
end
