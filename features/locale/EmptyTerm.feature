Feature: locale
  As a CSL cite processor hacker
  I want the test locale_EmptyTerm to pass

  @citation @locale
  Scenario: Empty Term
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
          <term name="and others">weird term</term>
        </terms>
      </locale>
      <citation>
        <layout>
          <text variable="title" suffix=": "/>
          <text term="and others" prefix="(" suffix=")"/>
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
    Sample Title: (weird term)
    """
