Feature: collapse
  As a CSL cite processor hacker
  I want the test collapse_AuthorCollapseNoDateSorted to pass

  @citation @collapse @citation-items
  Scenario: Author Collapse No Date Sorted
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
        collapse="year">
        <sort>
          <key variable="issued"/>
        </sort>
        <layout prefix="(" suffix=")" delimiter=", ">
          <group delimiter=" ">
            <names variable="author">
              <name form="short"/>
            </names>
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
    [{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[[325]]},"title":"Ignore me 1","type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[[2000]]},"title":"Ignore me 2","type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-3","title":"Ignore me 3","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"},{"id":"ITEM-2"},{"id":"ITEM-3"}]]
    """
    Then the results should be:
      | (Smith 325AD, 2000, [CSL STYLE ERROR: reference with no printed form.]) |
