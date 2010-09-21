Feature: Adding data source
  So that I can populate the data catalog
  As a registered user
  I want to be able to create a new data record

  @javascript
  Scenario Outline: A user adds a new data source
    Given I am a signed in <role>
    And an organization named "DCRA" exists
    When I follow "Add Data"
    And I fill in the data record fields
    And I choose "Provide an URL to an external file"
    And I fill in "External URL" with "http://document.url"
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
    And an organization named "DCRA" exists
    When I follow "Add Data"
    And I select "Johnny Minister" from "Added By"
    And I fill in the data record fields
    And I choose "Provide an URL to an external file"
    And I fill in "External URL" with "http://document.url"
    And I press "Submit"
    Then I should see "Your Data has been submitted"
    And the data record should be created by a ministry user

  Scenario: An admin adds a new data source with errors
    Given I am a signed in admin
    And an organization named "DCRA" exists
    When I follow "Add Data"
    And I fill in "Title" with ""
    And I press "Submit"
    Then I should not see "Your Data has been submitted"
    And I should see "Title can't be blank"
