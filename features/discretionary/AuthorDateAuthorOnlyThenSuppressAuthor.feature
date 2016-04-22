Feature: discretionary
  As a CSL cite processor hacker
  I want the test discretionary_AuthorDateAuthorOnlyThenSuppressAuthor to pass

  @citation @discretionary @citation-items
  Scenario: Author Date Author Only Then Suppress Author
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="in-text"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout prefix="(" suffix=")">
          <group delimiter=" ">
            <names variable="author">
              <name form="short"/>
            </names>
            <date variable="issued" form="text" date-parts="year"/>
          </group>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <text variable="title" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2005"]]},"title":"Book A","type":"book"},{"author":[{"family":"Jones","given":"Robert","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["2000"]]},"title":"Book B","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"author-only":1,"id":"ITEM-1"}],[{"id":"ITEM-1","suppress-author":1}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | Smith  |
      | (2005) |
      | (Jones 2000) |
