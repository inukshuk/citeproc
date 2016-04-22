Feature: number
  As a CSL cite processor hacker
  I want the test number_StrangeError to pass

  @citation @number
  Scenario: Strange Error
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          default-locale="fr">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <number variable="page"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"463-509","type":"article-journal"}]
    """
    When I cite all items
    Then the result should be:
    """
    463‑509
    """
