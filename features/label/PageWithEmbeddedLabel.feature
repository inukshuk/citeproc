Feature: label
  As a CSL cite processor hacker
  I want the test label_PageWithEmbeddedLabel to pass

  @citation @label @citations
  Scenario: Page With Embedded Label
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
          <label variable="page" form="short" suffix=". " strip-periods="true"/>
          <text variable="page"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"ch. 13","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] p. ch. 13
    """
