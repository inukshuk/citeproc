Feature: locale
  As a CSL cite processor hacker
  I want the test locale_OverloadWithEmptyString to pass

  @citation @locale
  Scenario: Overload With Empty String
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
          <term name="month-01">HIGHLY VISIBLE TERM</term>
        </terms>
      </locale>
      <locale xml:lang="en">
        <terms>
          <term name="month-01"></term>
        </terms>
      </locale>
      <citation>
        <layout>
          <text variable="title" suffix=": "/>
          <text value="("/>
          <text term="month-01"/>
          <text value=")"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Sample Title","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Sample Title: ()
    """
