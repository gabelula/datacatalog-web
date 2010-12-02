Feature: Marking data records as favorites
  So that I see the data records that I selected as favorites
  As a registered user 
  I want to select a data record as a favorite

  Background:
    Given I am a signed in user
    And a data record titled "The Data Record" exists

  @javascript
  Scenario: I mark a record as a favorite
    When I go to the data record's page
    And I follow the translation of "label_favorite_this_data_source"
    Then I should see the translation of "text_current_favorite"
    And I should see the translation of "text_remove_as_favorite"

  @javascript
  Scenario: I unmark a record as a favorite
    Given I favorited the data record
    When I go to the data record's page
    And I follow the translation of "label_remove_as_favorite"
    Then I should see the translation of "text_favorite_this_data"
    And I should see the translation of "label_favorite_this_data_source"

  Scenario: Favorite records show up in the dashboard
    Given I favorited the data record
    When I go to my dashboard
    Then I should see the favorited data record
