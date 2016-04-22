Feature: collapse
  As a CSL cite processor hacker
  I want the test collapse_TrailingDelimiter to pass

  @citation @collapse @citation-items
  Scenario: Trailing Delimiter
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
      <macro name="creator-key">
        <names variable="author">
          <name name-as-sort-order="all" sort-separator=", " />
        </names>
      </macro>
      <citation 
             after-collapse-delimiter="; "
             collapse="year-suffix"
             disambiguate-add-year-suffix="true"
             et-al-min="3"
             et-al-use-first="1"
             year-suffix-delimiter=", ">
        <sort>
          <key macro="creator-key" />
        </sort>
        <layout delimiter=", " prefix="(" suffix=")">
          <group delimiter=" ">
            <names variable="author">
              <name and="symbol" delimiter=", " form="short" />
              <et-al prefix=" " />
            </names>
            <date variable="issued">
              <date-part name="year" />
            </date>
          </group>
          <text variable="year-suffix" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Condit","given":"John","static-ordering":false},{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[["2000"]]},"title":"Book A","type":"book"},{"author":[{"family":"Condit","given":"John","static-ordering":false},{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[["1995"]]},"title":"Book B","type":"book"},{"author":[{"family":"Condit","given":"John","static-ordering":false},{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Smith","given":"John","static-ordering":false}],"id":"ITEM-3","issued":{"date-parts":[["1998"]]},"title":"Book C","type":"book"},{"author":[{"family":"Connell","given":"John","static-ordering":false}],"id":"ITEM-4","issued":{"date-parts":[["1971"]]},"title":"Book D","type":"book"},{"author":[{"family":"Cortes","given":"John","static-ordering":false},{"family":"Hunziker","given":"John","static-ordering":false}],"id":"ITEM-5","issued":{"date-parts":[["1971"]]},"title":"Book E","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"},{"id":"ITEM-2"},{"id":"ITEM-4"},{"id":"ITEM-3"},{"id":"ITEM-5"}]]
    """
    Then the results should be:
      | (Condit et al. 2000, 1995, 1998; Connell 1971, Cortes &amp; Hunziker 1971) |
