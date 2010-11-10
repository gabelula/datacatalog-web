Feature: View data record
  So that I can review my recently created records
  As a registered pop council user or guest
  I want to see the details of the data record I just created

  Background:
    Given the following data records exist:
      | title           | description | lead_organization_name | collaborator_list          | locations      | year | tag_list      |
      | The Data Record | Lorem Ipsum | Red Cross              | Free Medic, United Nations | Jamaica, Brazil| 2006 | foo, bar, baz | 

  Scenario: I see the record's attributes
    Given I am on the data record's page
    Then I should see "Lorem Ipsum"
    And I should see "Red Cross"
    And I should see "Free Medic"
    And I should see "United Nations"
    And I should see "jamaica"
    And I should see "brazil"
    And I should see "2006"
    And I should see "baz"
    And I should see "bar"
    And I should see "foo"

  Scenario: Clicking on a tag takes you to the filtered list view
    Given I am on the data record's page
    When I follow "foo"
    Then I should be browsing filtered by the "foo" tag

  Scenario: Clicking on the publication year takes you to the filtered list view
    Given I am on the data record's page
    When I follow "2006"
    Then I should be browsing records created on 2006
