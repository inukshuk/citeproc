Feature: label
  As a CSL cite processor hacker
  I want the test label_PluralPagesWithAlphaPrefix to pass

  @citation @label
  Scenario: Plural Pages With Alpha Prefix
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          page-range-format="expanded">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <group delimiter=" ">
            <label variable="page"/>
            <text variable="page"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"S213-S235","title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    pages S213–S235
    """
