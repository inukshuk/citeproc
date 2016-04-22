Feature: punctuation
  As a CSL cite processor hacker
  I want the test punctuation_NoSuppressOfPeriodBeforeSemicolon to pass

  @citation @punctuation
  Scenario: No Suppress Of Period Before Semicolon
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
          <group delimiter="; ">
            <text value="Hello" suffix="."/>
            <text value="Goodbye"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[["1965","6","1"]]},"title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Hello.; Goodbye
    """
