@signup @openid @users
Feature: Sign up via OpenID
  In order to register an account for the website
  As a site visitor
  I want to enter in my OpenID to create an account

  Scenario: Sign up with OpenID
    Given I am a site visitor
    When I go to sign up
    And I follow the translation of "text_openid_sign_up"
    And I fill by input id in "openid_identifier" with "http://johndoe.myopenid.com/"
    And I fill by input id in "openid_name" with "John D."
    And I fill by input id in "openid_email" with "john@test.com"
    And I select "Uruguay" by input id "openid_country"
    And I fill by input id in "openid_city" with "Montevideo"
    And I select "Journalist" by input id "openid_user_type"
    And I press the translation of "text_sign_up_with_openid"
    Then my OpenID-enabled account should be created
    And I should see the translation of "success_you_have_been_signed_in"
