Feature: locale
  As a CSL cite processor hacker
  I want the test locale_ForceEmptyEtAlTerm to pass

  @citation @locale
  Scenario: Force Empty Et Al Term
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
          <term name="et-al"></term>
        </terms>
      </locale>
      <citation et-al-min="3" et-al-use-first="1">
        <layout>
          <names variable="author">
            <name />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"},{"family":"Noakes","given":"Richard"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John Doe
    """
