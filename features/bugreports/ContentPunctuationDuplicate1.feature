Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_ContentPunctuationDuplicate1 to pass

  @citation @bugreports
  Scenario: Content Punctuation Duplicate1
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
          <group delimiter=". ">
            <text variable="title" quotes="true"/>
            <group delimiter=" ">
              <date variable="issued" form="text" date-parts="year" prefix="(" suffix=")"/>
              <text value="reference." font-style="italic"/>
            </group>
            <text value="blurble"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[["1965"]]},"title":"His Anonymous Life etc","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    “His Anonymous Life etc.” (1965) <i>reference.</i> blurble
    """
