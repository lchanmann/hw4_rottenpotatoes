Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  Movie.find_by_title(title).director.should == director
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  body.should =~ /#{e1}.*#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |rating|
    step %{I #{uncheck}check "ratings[#{rating}]"}
  end
end

Then /I should( not)? see the following movies/ do |not_see, movies_table|
  movies_table.hashes.each do |movie|
    step %{I should#{not_see} see "#{movie['title']}"}
  end
end

When /I (un)?check all ratings/ do |uncheck|
  step %{I #{uncheck}check the following ratings: #{Movie.all_ratings.join ', '}}
end

Then /I should see none of the movies/ do
  within_table("movies") do
    should_not have_selector("#movielist tr")
  end
end

Then /I should see all of the movies/ do
  movies_count = Movie.count
  within_table("movies") do
    should have_selector("#movielist tr", count: movies_count)
  end
end
