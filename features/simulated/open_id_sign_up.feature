@signup @openid @users
Feature: Sign up via OpenID
  In order to register an account for the website
  As a site visitor
  I want to enter in my OpenID to create an account

  Scenario: Sign up with OpenID
    Given I am a site visitor
    When I go to sign up
    And I follow the translation of "text_openid_sign_up"
    And I fill in "openid_url" with "http://johndoe.myopenid.com/"
    And I fill in "openid_name" with "John D."
    And I fill in "openid_email" with "john@test.com"
    And I select "Uruguay" from the translation of "openid_country"
    And I fill in "openid_city" with "Montevideo"
    And I select "Journalist" from the translation of "openid_user_type"
    And I press the translation of "text_sign_up_with_openid"
    Then my OpenID-enabled account should be created
    And I should see a translation of "success_you_have_been_signed_in"
