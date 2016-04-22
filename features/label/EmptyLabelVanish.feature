Feature: label
  As a CSL cite processor hacker
  I want the test label_EmptyLabelVanish to pass

  @citation @label
  Scenario: Empty Label Vanish
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
          <term name="page"></term>
        </terms>
      </locale>
      <citation>
        <layout>
          <text value="[start]"/>
          <group delimiter=" : " prefix="(" suffix=")">
            <label variable="page"/>
            <text variable="page-first"/>
          </group>
          <text value="[end]"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"22-45","title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    [start](22)[end]
    """
