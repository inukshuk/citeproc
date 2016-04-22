Feature: label
  As a CSL cite processor hacker
  I want the test label_NonexistentNameVariableLabel to pass

  @citation @label
  Scenario: Nonexistent Name Variable Label
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
          <names variable="composer">
            <name/>
    		<label/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"composer":[{"family":"Doe","given":"John"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John Doe
    """
