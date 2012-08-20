Feature: The displayed movies are filtered by rating
 
  As I don't accept some movie ratings
  So that I can avoid some unwanted kind of movies
  I want to see only some movies according to the rating that I select

Background: I have already added movies to the database 

  Given I have added these movies:
  | title                   | rating | release_date |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | Aladdin                 | G      | 25-Nov-1992  |
  | Amelie                  | R      | 25-Apr-2001  |
  | Chicken Run             | G      | 21-Jun-2000  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  And I am on the RottenPotatoes homepage

Scenario: restrict to movies to 'PG' or 'R'
  When I check the following ratings: PG, R
    And I uncheck the following ratings: G, PG-13, NC-17
    And I press "ratings_submit"
  Then I should see "Raiders of the Lost Ark"
    And I should see "The Terminator"
    And I should see "The Incredibles"
    And I should see "Amelie"
  And I should not see "Aladdin"
  And I should not see "The Help"
  And I should not see "Chicken Run"
  And I should not see "2001: A Space Odyssey"

Scenario: no ratings selected
  When I uncheck the following ratings: G, PG, PG-13, NC-17, R
    And I press "ratings_submit"
  Then I should not see any movies

Scenario: all ratings selected
  When I check the following ratings: G, PG, PG-13, NC-17, R
    And I press "ratings_submit"
  Then I should see all of the movies
  
Scenario: I check the following ratings: G, PG, R
  Given I check the following ratings: G, PG, R
  Then I should not see "The Help"
  And I should not see "Chocolat"
