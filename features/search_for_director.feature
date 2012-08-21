Feature: search movies using director keyword


  As I want to refine my search
  So that I can find movies directed by some director
  I want to add some kind of field to archeive this


Background: I have already added some movies

  Given I have added these movies:

  | title        | rating | director     | release_date |
  | Alien        | R      |              |   1979-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |


Scenario: add director to existing movie
  When I go to the edit page for "Alien"
  And  I fill in "Director" with "Ridley Scott"
  And  I press "Update Movie Info"
  Then the director of "Alien" should be "Ridley Scott"



Scenario: I can't find movies with same director if director field is not set (sad path)
  Given I am on the details page for "Alien"
  Then  I should not see "Ridley Scott"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the home page
  And   I should see "'Alien' has no director info"


Scenario: find movie with same director
  Given I am on the details page for "THX-1138"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "THX-1138"
  And   I should not see "Blade Runner"
  And   I should see "Star Wars"

