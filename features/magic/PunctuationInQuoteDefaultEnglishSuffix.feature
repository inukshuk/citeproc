Feature: magic
  As a CSL cite processor hacker
  I want the test magic_PunctuationInQuoteDefaultEnglishSuffix to pass

  @citation @magic
  Scenario: Punctuation In Quote Default English Suffix
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
        <layout suffix="." delimiter="[z]">
          <names suffix=", " variable="author" delimiter="[x]">
            <name form="short" delimiter="[y]"/>
          </names>
          <text quotes="true" suffix=", " variable="title" />
          <date variable="issued">
            <date-part name="year" />
          </date>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[[1900]]},"title":"Book A","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Doe, “Book A,” 1900.
    """
