@signup @openid @users
Feature: Sign up via OpenID
  In order to register an account for the website
  As a site visitor
  I want to enter in my OpenID to create an account
  
  Scenario: Sign up with OpenID
    Given I am a site visitor
    When I go to sign up
    And I fill in "OpenID URL" with "http://johndoe.myopenid.com/"
    And I fill in "openid_name" with "John D."
    And I fill in "openid_email" with "john@test.com"
    And I press "Sign Up via OpenID"
    Then my OpenID-enabled account should be created
    
  Scenario: Attempt to sign in without confirming email address
    Given I have signed up via OpenID but not yet confirmed
    When I go to sign in
    And I fill in "OpenID URL" with "http://someid.com/"
    And I press "Sign In"
    Then I should see "Your account is not confirmed"