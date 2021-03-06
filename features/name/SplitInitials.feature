Feature: name
  As a CSL cite processor hacker
  I want the test name_SplitInitials to pass

  @citation @name
  Scenario: Split Initials
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
            <name initialize-with=""/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"J.J.","static-ordering":false}],"id":"simple-western-name-1","issued":{"date-parts":[["1965","6","1"]]},"title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    JJ Doe
    """
