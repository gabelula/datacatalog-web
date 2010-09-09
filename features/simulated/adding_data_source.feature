Feature: Adding data source
  So that I can populate the data catalog
  As a registered pop council admin
  I want to be able to create a new data record

  Scenario: An admin adds a new data source
    Given I am a signed in admin
    And an organization named "DCRA" exists
    When I follow "Add Data"
    And I fill in "Title" with "Housing Code Enforcement"
    And I fill in "Description" with "Blah blah blah blah"
    And I select "Uruguay" from "Country"
    And I select "DCRA" from "Organization"
    And I fill in "Author Name" with "Pepe Perez"
    And I fill in "Author Affiliation" with "DCRA Member"
    And I fill in "Data URL" with "http://data.dc.gov/foo"
    And I select "Published" from "Status"
    And I fill in "Project Name" with "The Project"
    And I fill in "Funder" with "Uncle Sam"
    And I fill in "Year" with "2008"
    And I fill in "Tags" with "housing, code enforcement, something else"
    And I fill in "Name" with "John Doe"
    And I fill in "Phone" with "+1 (234) 567 8900"
    And I fill in "Email" with "john.doe@example.org"
    And I press "Submit"    
    Then I should see "Your Data has been submitted"
