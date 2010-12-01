Given /^the data record has notes by a different user$/ do
  the.data_record.notes.create(:text => 'other')
end

When /^I write a new note for the data record$/ do 
  When 'I fill in "note_text" with "text"'
  And 'I press the translation of "text_save_notes"'
end

Then /^I should see my note$/ do
  note = the.user.notes.last.text

  page.should have_content("#{note}")
end

Then /^I should not see the other user's notes$/ do
  page.should_not have_content("other") 
end
