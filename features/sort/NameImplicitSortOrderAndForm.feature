Feature: sort
  As a CSL cite processor hacker
  I want the test sort_NameImplicitSortOrderAndForm to pass

  @bibliography @sort
  Scenario: Name Implicit Sort Order And Form
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
      <macro name="author-name">
        <names variable="author">
          <name form="short"/>
        </names>
      </macro>
      <citation>
        <layout>
            <text value="Ignore me"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key macro="author-name"/>
        </sort>
        <layout>
          <text macro="author-name"/>
          <text variable="title" prefix=", "/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Roe","given":"Jane","static-ordering":false}],"id":"ITEM-1","title":"Book A","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"ITEM-2","title":"Book C","type":"book"},{"author":[{"family":"Doe","given":"James","static-ordering":false}],"id":"ITEM-3","title":"Book B","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Doe, Book C</div>
      <div class="csl-entry">Doe, Book B</div>
      <div class="csl-entry">Roe, Book A</div>
    </div>
    """
