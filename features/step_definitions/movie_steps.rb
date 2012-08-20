
movies_count = 0
Given /I have added these movies/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    movies_count += 1
  end
end



Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  is_match = /#{e1}.*#{e2}/m =~ page.body
  assert !is_match.nil?
end


Then /I should see all of the movies/ do
  page.should have_css("table#movies tbody tr", :count => movies_count.to_i)
end


Then /I should not see any movies/ do
  page.should have_no_css("table#movies tbody tr")
end

When /I (un)?check the following ratings: (.*)/ do |is_unchecked, rating_list|
  rating_list.split(',').each { |r|
    ratings_str = 'ratings[' + r.strip + ']'
    if is_unchecked.nil?
      uncheck(ratings_str)
    else
      check(ratings_str)
    end
  }
end



