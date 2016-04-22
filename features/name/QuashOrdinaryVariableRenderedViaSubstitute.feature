Feature: name
  As a CSL cite processor hacker
  I want the test name_QuashOrdinaryVariableRenderedViaSubstitute to pass

  @citation @name
  Scenario: Quash Ordinary Variable Rendered Via Substitute
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
            <substitute>
              <text variable="title"/>
            </substitute>
          </names>
          <text variable="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Case Name","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Case Name
    """
