Feature: Adding data source
  So that I can populate the data catalog
  As a registered user
  I want to be able to create a new data record

  Scenario: A guest can't add a new data source
    Given I am a site visitor
    When I follow "Add Data"
    Then I should see "You must be logged in to take that action"
    And I should not see "Add Data Source"

  @javascript
  Scenario Outline: A user adds a new data source
    Given I am a signed in <role>
    When I follow "Add Data"
    And I fill in the data record fields
    And I press "Submit"
    Then I should see "Your Data has been submitted"
    And the data record should be created by a <role>

    Examples:
    | role          |
    | admin         |
    | ministry user |
    | user          |

  @javascript
  Scenario: An admin adds a data record as a ministry user
    Given I am a signed in admin
    And a ministry user named "Johnny Minister" with "johnny@ministry.com" exists
    When I follow "Add Data"
    And I select "Johnny Minister" from "Added By"
    And I fill in the data record fields
    And I press "Submit"
    Then I should see "Your Data has been submitted"
    And the data record should be created by a ministry user

  Scenario: An admin adds a new data source with errors
    Given I am a signed in admin
    When I follow "Add Data"
    And I fill in "Title" with ""
    And I fill in "Lead Organization" with "Some Org"
    And I press "Submit"
    Then I should not see "Your Data has been submitted"
    And I should see "Title can't be blank"
    And there should be no organizations

  Scenario Outline: Creating organizations if they don't exist yet
    Given I am a signed in user
    And an organization named "DCRA" exists
    When I follow "Add Data"
    And I fill in the data record fields
    And I fill in "Lead Organization" with "<name>"
    And I fill in "Other Institutional Collaborators" with "<collaborators>"
    And I press "Submit"
    Then I should see "Your Data has been submitted"
    And there should be <count> organizations
    And the data record's lead organization should be "<name>"

    Examples:
    | name      | collaborators      | count |
    | DCRA      | United Nations     | 2     |
    | Red Cross | DCRA, Free Medic   | 3     |
    | Red Cross | DCRA               | 2     |
    | Red Cross |                    | 2     |

  Scenario: The lead organization defaults to the user's affiliation
    Given I am a signed in user
    And I am affiliated to "Red Cross International"
    When I follow "Add Data"
    Then the "Lead Organization" field should contain "Red Cross International"

  @javascript
  Scenario: A user adds a data record covering multiple regions
    Given I am a signed in user
    When I follow "Add Data"
    And I fill in the data record fields
    And I select "Africa" from "Geographical Coverage"
    And I follow "+ Add Another"
    And I select "Asia" from the 2nd "Geographical Coverage"
    And I press "Submit"
    Then I should see "Your Data has been submitted"
    And I should see "Africa, Asia"

  @javascript
  Scenario: Setting a data record to have Global coverage should delete any other region
    Given I am a signed in user
    When I follow "Add Data"
    And I fill in the data record fields
    And I select "Africa" from "Geographical Coverage"
    And I follow "+ Add Another"
    And I select "Asia" from the 2nd "Geographical Coverage"
    And I select "Global" from "Geographical Coverage"
    And I press "Submit"
    Then I should see "Your Data has been submitted"
    And I should see "Global"
    But I should not see "Africa"
    And I should not see "Asia"

#  @javascript
#  Scenario: A data record can have up to 3 authors
#    Given I am a signed in user
#    When I follow "Add Data"
#    And I fill in the data record fields
#    And I follow "+ Add Author"
#    And I fill in the 1st author name with "John Doe"
#    And I follow "+ Add Author"
#    And I fill in the 2nd author name with "Jane Doe"
#    And I follow "+ Add Author"
#    And I fill in the 3rd author name with "Tom From MySpace"
#    Then the "+ Add Author" link should be hidden
#    When I press "Submit"
#    Then I should see "Your Data has been submitted"
#    And I should see "John Doe"
#    And I should see "Jane Doe"
#    And I should see "Tom From MySpace"

#  @javascript
#  Scenario: A data record author's affiliation defaults to its lead organization
#    Given I am a signed in user
#    When I follow "Add Data"
#    And I fill in the data record fields
#    And I fill in "Lead Organization" with "Red Cross"
#    And I follow "+ Add Author"
#    Then the "Author Affiliation" field should contain "Red Cross"
#    When I fill in the 1st author name with "John Doe"
#    And I press "Submit"
#    Then I should see "Your Data has been submitted"
#    And I should see "John Doe (Red Cross)"
