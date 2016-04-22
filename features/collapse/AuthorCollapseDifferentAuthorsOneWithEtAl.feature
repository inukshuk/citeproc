Feature: collapse
  As a CSL cite processor hacker
  I want the test collapse_AuthorCollapseDifferentAuthorsOneWithEtAl to pass

  @citation @collapse
  Scenario: Author Collapse Different Authors One With Et Al
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
        collapse="year"
        et-al-min="2"
        et-al-use-first="1">
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
    [{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[[1900]]},"type":"book"},{"author":[{"family":"Smith","given":"John"},{"family":"Jones","given":"Rodney"}],"id":"ITEM-2","issued":{"date-parts":[[2000]]},"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    (Smith 1900, Smith et al. 2000)
    """
