Feature: integration
  As a CSL cite processor hacker
  I want the test integration_DeleteName to pass

  @citation @integration @citations
  Scenario: Delete Name
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
        <layout suffix="." delimiter="; ">
          <names variable="author">
            <name form="short"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Snoakes","given":"Richard","static-ordering":false}],"id":"ITEM-3","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Doe; Snoakes.
    """
