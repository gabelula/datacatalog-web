Given /^the data record has (\d+) ratings? worth (\d+) stars?$/ do |count, stars|
  count.to_i.times do
    Rating.create(:value => stars.to_i, :data_record_id => the.data_record.id)
  end
end

Given /^I previously rated the data record (\d+) stars$/ do |stars|
  the.user.ratings.create(:data_record_id => the.data_record.id, :value => stars.to_i)
end

When /^I rate it (\d+) stars$/ do |stars|
  within :css, "#yourRating" do
    click_link stars
  end
end

Then /^I should see the average rating is (\d+)$/ do |stars|
  css_class = case stars.to_i
    when 1; ".ratedOneStar"
    when 2; ".ratedTwoStars"
    when 3; ".ratedThreeStars"
    when 4; ".ratedFourStars"
    when 5; ".ratedFiveStars"
    else    "THIS WILL FAIL"
  end

  page.should have_css("#overallRating #{css_class}")
end

Then /^I should see it was rated by (\d+) people$/ do |count|
  page.should have_content("#{I18n.t(:text_averaged_from)} #{count}")
end
