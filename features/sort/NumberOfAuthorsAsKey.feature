Feature: sort
  As a CSL cite processor hacker
  I want the test sort_NumberOfAuthorsAsKey to pass

  @bibliography @sort
  Scenario: Number Of Authors As Key
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
      <macro name="author-one">
        <names variable="author">
          <name name-as-sort-order="first" sort-separator=" "/>
          <substitute>
            <names variable="editor" />
          </substitute>
        </names>
      </macro>
      <macro name="author-count">
        <names variable="author">
          <name form="count" />
          <substitute>
            <names variable="editor" />
          </substitute>
        </names>
      </macro>
      <macro name="theyear">
        <date variable="issued">
          <date-part name="year" />
        </date>
      </macro>
      <citation>
        <layout>
          <text value="Ignore me" />
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key macro="author-one" names-min="1" names-use-first="1" />
          <key macro="author-count" names-min="3" names-use-first="3" />
          <key macro="theyear" />
        </sort>
        <layout>
          <text variable="title" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"item-1","issued":{"date-parts":[["2000"]]},"title":"Book One","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Doe","given":"Jake","static-ordering":false},{"family":"Jones","given":"Robert","static-ordering":false}],"id":"item-2","issued":{"date-parts":[["2000"]]},"title":"Book Three","type":"book"},{"editor":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false}],"id":"item-3","issued":{"date-parts":[["2000"]]},"title":"Book Two","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Book One</div>
      <div class="csl-entry">Book Two</div>
      <div class="csl-entry">Book Three</div>
    </div>
    """
