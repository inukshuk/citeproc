Feature: magic
  As a CSL cite processor hacker
  I want the test magic_TextRangeFrench to pass

  @citation @magic
  Scenario: Text Range French
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          default-locale="fr-FR">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <text variable="page"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"1-3","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    1‑3
    """
