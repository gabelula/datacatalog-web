Feature: Adding data source
  So that I can populate the data catalog
  As a registered user
  I want to be able to create a new data record

  Scenario: A guest can't add a new data source
    Given I am a site visitor
    When I follow the translation of "label_add_data"
    Then I should see the translation of "message_you_must_be_logged_in_to_take_that_action"
    And I should not see the translation of "text_add_data_source"

  @javascript
  Scenario Outline: A user adds a new data source
    Given I am a signed in <role>
    When I follow the translation of "label_add_data"
    And I fill in the data record fields
    And I press the translation of "text_submit"
    Then I should see the translation of "message_your_data_has_been_submitted"
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
    When I follow the translation of "label_add_data"
    And I select "Johnny Minister" from the translation of "text_added_by"
    And I fill in the data record fields
    And I press the translation of "text_submit"
    Then I should see the translation of "message_your_data_has_been_submitted"
    And the data record should be created by a ministry user

  Scenario: An admin adds a new data source with errors
    Given I am a signed in admin
    When I follow the translation of "label_add_data"
    And I fill in "text_title" with ""
    And I fill in "text_lead_organization" with "Some Org"
    And I press the translation of "text_submit"
    Then I should not see the translation of "message_your_data_has_been_submitted"
    And I should see the translation of "title_cant_be_blank" 
    And there should be no organizations

  Scenario Outline: Creating organizations if they don't exist yet
    Given I am a signed in user
    And an organization named "DCRA" exists
    When I follow the translation of "label_add_data"
    And I fill in the data record fields
    And I fill in "text_lead_organization" with "<name>"
    And I fill in "text_other_institutional_collaborators" with "<collaborators>"
    And I press the translation of "text_submit"
    Then I should see the translation of "message_your_data_has_been_submitted"
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
    When I follow the translation of "label_add_data"
    Then the "text_lead_organization" field should contain "Red Cross International"

#  @javascript
#  Scenario: A data record can have up to 3 authors
#    Given I am a signed in user
#    When I follow the translation of "label_add_data"
#    And I fill in the data record fields
#    And I follow "add_author"
#    And I fill in the 1st author name with "John Doe"
#    And I follow "add_author"
#    And I fill in the 2nd author name with "Jane Doe"
#    And I follow "add_author"
#    And I fill in the 3rd author name with "Tom From MySpace"
#    Then the "+ Add Author" link should be hidden
#    When I press the translation of "text_submit"
#    Then I should see "message_your_data_has_been_submitted"
#    And I should see "John Doe"
#    And I should see "Jane Doe"
#    And I should see "Tom From MySpace"

#  @javascript
#  Scenario: A data record author's affiliation defaults to its lead organization
#    Given I am a signed in user
#    When I follow the translation of "label_add_data"
#    And I fill in the data record fields
#    And I fill in "Lead Organization" with "Red Cross"
#    And I follow "add_author"
#    Then the "Author Affiliation" field should contain "Red Cross"
#    When I fill in the 1st author name with "John Doe"
#    And I press the translation of "Submit"
#    Then I should see "message_your_data_has_been_submitted"
#    And I should see "John Doe (Red Cross)"

  Scenario: By default the contact information is pre-filled from the user's information
    Given I am a signed in user
    When I follow the translation of "label_add_data"
    Then the contact name field should contain the user's name
    And the contact email field should contain the user's email
    But the contact phone field should be blank
