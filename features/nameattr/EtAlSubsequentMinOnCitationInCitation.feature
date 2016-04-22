Feature: nameattr
  As a CSL cite processor hacker
  I want the test nameattr_EtAlSubsequentMinOnCitationInCitation to pass

  @citation @nameattr @citation-items
  Scenario: Et Al Subsequent Min On Citation In Citation
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
      <citation
          et-al-subsequent-min="2">
        <layout>
          <names variable="author">
            <name et-al-subsequent-use-first="1"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","position":1}]]
    """
    Then the results should be:
      | John Doe et al. |
