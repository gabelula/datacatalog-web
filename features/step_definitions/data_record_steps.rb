Given /^a data record titled "(.*)" exists$/ do |title|
  Given %Q(an organization named "Red Cross" exists)

  the.data_record = DataRecord.make(:title => title, :lead_organization_name => the.organization.name)
end

Given /^a data record titled "(.*)" exists whose owner's email is "(.*)"$/ do |title, owner_email|
  Given %Q(an user named "John Doe" with "#{owner_email}" exists)
  the.data_record = DataRecord.make(:title => title, :owner => the.user)
end

Given /^the following data records exist:$/ do |table|
  table.hashes.each do |attr|
    if (ministry_name = attr.delete("ministry")) && ministry_name.present?
      attr["owner"] = User.ministry_users.find_by_display_name(ministry_name) || User.make(:display_name => ministry_name, :role => "ministry_user")
    end

    if (locations = attr.delete("locations").to_s.split(/\s*,\s*/)) && locations.present?
      attr["data_record_locations"] = locations.map {|loc| DataRecordLocation.new(:location_id => Location.find_by_name(loc).id) }
    end

    if (ratings = attr.delete("ratings").to_s.split(/\s*,\s*/)) && ratings.present?
      attr["ratings"] = ratings.map {|val| Rating.new(:value => val, :user => User.make) }
    end

    if (documents = attr.delete("documents").to_s.split(/\s*,\s*/)) && documents.present?
      attr["documents"] = documents.map {|type| Document.make_unsaved(:document_type => type) }
    end

    DataRecord.make(attr)
  end
end

Given /^I favorited the data record$/ do
  the.user.favorite_records << the.data_record
end

When /^I fill in the data record fields$/ do
  When %Q(I fill in "text_title" with "Housing Code Enforcement")
  When %Q(I fill in "text_description" with "Blah blah blah blah")
  When %Q(I select "Uruguay" from the translation of "text_geographical_coverage")
  When %Q(I fill in "text_lead_organization" with "Red Cross International")
  When %Q(I fill in "text_other_institutional_collaborators" with "Doctors Without Borders, United Nations")
  When %Q(I fill in "text_homepage_url" with "http://data.dc.gov/foo")
  When %Q(I fill in "text_project_name" with "The Project")
  When %Q(I fill in "text_funder" with "Uncle Sam")
  When %Q(I select "2008" from the translation of "text_publication_year")
  When %Q(I fill in "text_tags" with "housing, code enforcement, something else")

  # contact
  When %Q(I fill in "text_name" with "John Doe")
  When %Q(I fill in "text_phone" with "+1 (234) 567 8900")
  When %Q(I fill in "text_email" with "john.doe@example.org")

  # documents
  When %Q(I choose "text_storage_external")
  When %Q(I fill in "text_external_url" with "http://document.url/file.csv")
  When %Q(I select "Data" from the translation of "text_document_type")
end

When /^I fill in the (\w+) author name with "([^\"]+)"$/ do |position, value|
  %Q(When I fill in the #{position.to_i + 1} "Author Name" with "#{value}")
end

When /^I sort by "([^\"]+)" (\w+)$/ do |field, order|
  # Clicking the sorting link the first time sorts descending,
  # clicking it the second time sorts ascending
  When %Q(I follow "#{field}")
  When %Q(I follow "#{field}") if order == "descending"
end

Then /^I should see the favorited data record$/ do
  Then %Q(I should see "#{the.data_record.title}")
end

Then /^the data record should be created by a (.+)$/ do |role|
  # FIXME: This should be featured in the UI, not checked in the database
  DataRecord.last.owner.role.should == normalize_role(role)
end

Then /^I should(?: only)? see (\d+) records?$/ do |count|
  page.should have_css("#browseTable tbody tr", :count => count.to_i)
end

Then /^I should see ministry records before community records$/ do
  ministry_records, community_records = DataRecord.sorted(nil).partition do |data_record|
    data_record.ministry
  end

  page.should have_css("#data_record_#{ministry_records.last["id"]} + #data_record_#{community_records.first["id"]}")
end

Then /^I should see a record tagged "(.*)"$/ do |tag|
  within :css, "tr.data_record .tags" do
    Then %Q(I should see "#{tag}")
  end
end

Then /^the data record's lead organization should be "(.+)"$/ do |name|
  DataRecord.last.lead_organization.name.should == name
end

Then /^I should be browsing filtered by the "([^\"]+)" tag$/ do |tag|
  Then %Q(I should be on the browse page)
  Then %Q(I should see a translation of "label_browse_by_tag")
  Then %Q(I should see a record tagged "#{tag}")
end

Then /^I should be browsing records created on (\d+)$/ do |year|
  Then %Q(I should be on the browse page)
  Then %Q(the "Release Year" field should contain "#{year}")
end

Then /^the contact (\w+) field should contain the user's (\w+)$/ do |field, attribute|
  Then %Q(the "#{field.titleize}" field should contain "#{the.user.send(attribute)}")
end

Then /^the contact (\w+) field should be blank$/ do |field|
  find_field(field.titleize)["value"].should be_blank
end

Then /^"([^\"]+)" should come before "([^\"]+)"$/ do |first_title, second_title|
  first, second = DataRecord.find_by_title(first_title), DataRecord.find_by_title(second_title)
  page.should have_css("#data_record_#{first["id"]} ~ #data_record_#{second["id"]}")
end
