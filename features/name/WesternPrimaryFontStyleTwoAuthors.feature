Feature: name
  As a CSL cite processor hacker
  I want the test name_WesternPrimaryFontStyleTwoAuthors to pass

  @citation @name
  Scenario: Western Primary Font Style Two Authors
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <names variable="author">
            <name delimiter="; ">
              <name-part font-weight="bold" name="family" />
            </name>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false}],"id":"item-1","issued":{"date-parts":[["2000"]]},"title":"Our Anonymous Lives","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John <b>Doe</b>; Jane <b>Roe</b>
    """
