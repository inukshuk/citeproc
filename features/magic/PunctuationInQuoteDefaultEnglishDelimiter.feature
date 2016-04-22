Feature: magic
  As a CSL cite processor hacker
  I want the test magic_PunctuationInQuoteDefaultEnglishDelimiter to pass

  @citation @magic
  Scenario: Punctuation In Quote Default English Delimiter
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
        <layout suffix=".">
          <group delimiter=", ">
            <names variable="author">
              <name form="short" />
            </names>
            <text quotes="true" variable="title" />
            <date variable="issued">
              <date-part name="year" />
            </date>
          </group>
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
