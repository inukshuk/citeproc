Feature: affix
  As a CSL cite processor hacker
  I want the test affix_TextNodeWithMacro to pass

  @citation @affix
  Scenario: Text Node With Macro
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
        <style-options punctuation-in-quote="false"/>
      </locale>
      <macro name="two">
        <text value="Two"/>
      </macro>
      <citation>
        <layout suffix=".">
          <text value="One"/>
          <text macro="two" prefix=". "/>
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
    One. Two.
    """
