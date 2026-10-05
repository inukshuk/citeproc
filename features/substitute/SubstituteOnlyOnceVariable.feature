Feature: substitute
  As a CSL cite processor hacker
  I want the test substitute_SubstituteOnlyOnceVariable to pass

  @citation @substitute
  Scenario: Substitute Only Once Variable
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
              <text variable="title"/>
              <text variable="container-title"/>
            </substitute>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"ContainerTitle","id":"ITEM-1","title":"Title","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Title
    """
