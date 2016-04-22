Feature: name
  As a CSL cite processor hacker
  I want the test name_ArticularPlain to pass

  @citation @name
  Scenario: Articular Plain
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
            <name />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"James","static-ordering":false,"suffix":"III"}],"id":"item-1","issued":{"date-parts":[["2001"]]},"title":"My Anonymous Heritage","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    James Doe III
    """
