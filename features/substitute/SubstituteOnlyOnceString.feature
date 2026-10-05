Feature: substitute
  As a CSL cite processor hacker
  I want the test substitute_SubstituteOnlyOnceString to pass

  @citation @substitute
  Scenario: Substitute Only Once String
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2019-08-11T16:56:00+02:00</updated>
      </info>
      <citation>
        <layout>
          <names variable="author">
            <substitute>
              <text value="a"/>
              <text value="b"/>
            </substitute>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    a
    """
