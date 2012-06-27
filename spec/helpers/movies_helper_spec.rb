require 'spec_helper'

describe MoviesHelper do
  [1,3,5,7,9,11,111].each do |i|
    it "#{i} should be odd" do
      helper.oddness(i).should == 'odd'
    end
  end

  [2,4,6,8,10,50,238].each do |i|
    it "#{i} should be even" do
      helper.oddness(i).should == 'even'
    end
  end
end
