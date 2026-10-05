Feature: name
  As a CSL cite processor hacker
  I want the test name_FirstInitialFullForm to pass

  @citation @name @citation-items
  Scenario: First Initial Full Form
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
            <name initialize-with=". " initialize="false"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"A. Alan"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | A. Alan Aalto |
