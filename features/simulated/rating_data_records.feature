Feature: Rating data records
  So that I can see which records are better
  As a registered user 
  I want to rate a data record with 1 to 5 stars

  Background:
    Given I am a signed in user
    And a data record titled "The Data Record" exists

  @javascript
  Scenario Outline: I rate for a record with no previous ratings
    When I go to the data record's page
    And I rate it <stars> stars
    Then I should see the average rating is <average>
    And I should see it was rated by <count> people

    Examples:
    | stars | average | count |
    | 1     | 1       | 1     |
    | 2     | 2       | 1     |
    | 3     | 3       | 1     |
    | 4     | 4       | 1     |
    | 5     | 5       | 1     |

  @javascript
  Scenario Outline: I rate for a record with previous ratings
    Given the data record has 1 rating worth 2 stars
    When I go to the data record's page
    And I rate it <stars> stars
    Then I should see the average rating is <average>
    And I should see it was rated by <count> people

    Examples:
    | stars | average | count |
    | 1     | 1       | 2     |
    | 2     | 2       | 2     |
    | 3     | 2       | 2     |
    | 4     | 3       | 2     |
    | 5     | 3       | 2     |

  @javascript
  Scenario Outline: I update my rate for a record
    Given the data record has 1 rating worth 2 stars
    And I previously rated the data record 4 stars
    When I go to the data record's page
    And I rate it <stars> stars
    Then I should see the average rating is <average>
    And I should see it was rated by <count> people

    Examples:
    | stars | average | count |
    | 1     | 1       | 2     |
    | 2     | 2       | 2     |
    | 3     | 2       | 2     |
    | 4     | 3       | 2     |
    | 5     | 3       | 2     |

  @javascript
  Scenario: Guests can't rate data records
    Given I am a site visitor
    And I am on the data record's page
    And I rate it 4 stars
    Then I should see the translation of "message_you_must_be_logged_in_to_take_that_action"
    And I should be on the sign in page
