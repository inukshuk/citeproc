Feature: locale
  As a CSL cite processor hacker
  I want the test locale_EffectOfStyleDefinition to pass

  @citation @locale
  Scenario: Effect Of Style Definition
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
      <locale xml:lang="en-US">
        <term name="and">und</term>
      </locale>
      <citation>
        <layout>
          <names variable="author">
            <name and="symbol"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John Doe &amp; Jane Roe
    """
