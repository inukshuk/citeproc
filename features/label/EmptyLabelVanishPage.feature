Feature: label
  As a CSL cite processor hacker
  I want the test label_EmptyLabelVanishPage to pass

  @citation @label @citation-items
  Scenario: Empty Label Vanish Page
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
      <locale>
        <terms>
          <term name="page" form="short"></term>
        </terms>
      </locale>
      <macro name="juris-locator">
        <text variable="locator" prefix="{" suffix="}"/>
      </macro>
      <citation>
        <layout>
          <text macro="juris-locator" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"My Title","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","locator":"53"}]]
    """
    Then the results should be:
      | {53} |
