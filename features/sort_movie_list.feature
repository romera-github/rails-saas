Feature: display the list of movies ordered by date or title
 
  As I want to order my movies
  So that I can quickly access them
  I want to see them ordered by title or by date

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
  And I am on the RottenPotatoes home page
  
Scenario: sort movies alphabetically
  When I check the following ratings: G, PG, PG-13, NC-17, R
    And I press "ratings_submit"
    And I follow "order_header"
  Then I should see "Aladdin" before "Amelie"

Scenario: sort movies in increasing order of release date
  When I check the following ratings: G, PG, PG-13, NC-17, R
    And I press "ratings_submit"
    And I follow "release_date_header"
  Then I should see "1968-06-04 00:00:00 UTC" before "2004-11-05 00:00:00 UTC"



