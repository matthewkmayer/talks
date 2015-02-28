Feature: User testing
  As a consumer of the users service
  I want to get a list of all users

  Scenario: Get all users
    When I hit the all users endpoint
    Then I should get a list of all users

  Scenario: Get user 1
    When I ask for the details of user 1
    Then I should get the details for user 1
