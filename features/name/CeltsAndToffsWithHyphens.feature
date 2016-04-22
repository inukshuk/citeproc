Feature: name
  As a CSL cite processor hacker
  I want the test name_CeltsAndToffsWithHyphens to pass

  @citation @name
  Scenario: Celts And Toffs With Hyphens
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          initialize-with-hyphen="true">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <names variable="translator">
            <name and="symbol" delimiter=", " delimiter-precedes-last="always" initialize-with="." name-as-sort-order="all" sort-separator=", " />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"item-1","issued":{"date-parts":[["1933"]]},"title":"Book A","translator":[{"family":"Chen","given":"Hsien-Li","static-ordering":false}],"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Chen, H.-L.
    """
