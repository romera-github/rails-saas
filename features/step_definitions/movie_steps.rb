movies_count = 0

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  is_match = /#{e1}.*#{e2}/m =~ page.body
  assert !is_match.nil?
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  m = Movie.find_by_title(title)
  m.director.should == director
end 


Given /I have added these movies/ do |movies_table|
  movies_table.hashes.each do |movie|
    movies_count += 1
    Movie.create!(movie)
  end
end

When /I (un)?check the following ratings: (.*)/ do |is_unchecked, rating_list|
  rating_list.delete!("\"")
  rating_list.split(',').each { |r|
    ratings_str = "ratings[" + r.strip + "]"
    if is_unchecked.nil?
      check(ratings_str)
    else
      uncheck(ratings_str)
    end
  }
end

Then /I should see (all\sof\sthe|no) movies/ do |flag|
  movies = page.find('#movies')
  rows = movies.all('tr').length
  expected = (flag == 'no') ? 0 : 11
  assert expected == rows
end
