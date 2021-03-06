Feature: Watchers for conversations

  Background: 
    Given a project with users @mislav, @balint, @pablo and @james
    And I am logged in as @mislav

  Scenario: New conversation watchers
    When I go to the new conversation page
    And I fill in "Title" with "Talk!"
    And I fill in the comment box with "We need to discuss!"
    And I press "Create"
    Then @balint, @pablo and @james should be watching the conversation "Talk!"
    When I fill in the comment box with "Rockets!"
    And I press "Save"
    Then @balint, @pablo and @james should receive 2 emails

  Scenario: Existing conversation with watchers
    Given I started a conversation named "Politics"
    And the conversation "Politics" is watched by @pablo and @james
    When I go to the conversations page
    And I follow "Politics"
    And I fill in the comment box with "Senators!"
    And I press "Save"
    And I fill in the comment box with "Rockets!"
    And I press "Save"
    Then @balint should receive no emails
    And @pablo and @james should receive 2 emails

  Scenario: User leaves project
    Given I started a conversation named "Politics"
    And the conversation "Politics" is watched by @balint, @pablo and @james
    And @pablo left the project
    When I go to the conversations page
    And I follow "Politics"
    And I fill in the comment box with "Celebrities!"
    And I press "Save"
    And I fill in the comment box with "Controversy!"
    And I press "Save"
    Then @pablo should receive no emails
    And @balint and @james should receive 2 emails
