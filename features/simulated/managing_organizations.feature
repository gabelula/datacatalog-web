Feature: Managing Organizations
  So that I can control Organizations in the system
  As a pop council admin
  I want to manage organizations

  Background:
    Given I am a signed in admin
    And an organization named "Red Cross" exists
    And an organization named "Some Org" exists

  Scenario Outline: Admin adds an organization
    When I go to the admin dashboard
    And I follow the translation of "label_organizations"
    When I follow the translation of "text_add_organization"
    And I fill in "name" with "Aspiration"
    And I fill in "acronym" with "ASP"
    And I select "<parent>" from the translation of "parent"  
    And I select "Uruguay" from the translation of "country"  
    And I fill in "website" with "http://www.aspiration.org"
    And I fill in "home_page" with "http://www.aspiration.org"
    And I select "Not-For-Profit" from the translation of "type"
    And I fill in "description" with "This is a nice NGO."
    And I press the translation of "text_submit"
    Then I should see "Aspiration"
    And the organization's parent should be "<parent>"

    Examples:
    | parent    |
    |           |
    | Red Cross |

  Scenario: Admin edits an organization
    When I go to the admin dashboard
    And I follow the translation of "label_organizations"
    When I follow "Red Cross"
    And I fill in "name" with "Red Cross International"
    And I press the translation of "label_update"
    Then I should see "Red Cross International"
