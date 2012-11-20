Feature: Merge Posts
  As a blog administrator
  In order to combine two articles
  I want to be able to edit a article and merge it with another

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: An admin should be able to merge articles
    Given there is an article called "First Article" with text "first"
    And the article "First Article" has a comment "awesome"
    And there is an article called "Second Article" with text "second"
    And the article "Second Article" has a comment "bad"
    When I edit the article "First Article"
    And I fill in "merge_with" with article "Second Article"
    And I press "Merge"
    Then the article "Second Article" should no longer exist
    And the article "First Article" should contain "second"
    And the article "First Article" should have the comment "awesome"
    And the article "First Article" should have the comment "bad"
