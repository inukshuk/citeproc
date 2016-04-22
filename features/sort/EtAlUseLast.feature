Feature: sort
  As a CSL cite processor hacker
  I want the test sort_EtAlUseLast to pass

  @bibliography @sort
  Scenario: Et Al Use Last
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
      <bibliography
    		 et-al-use-last="true" 
    		 et-al-min="4" 
    		 et-al-use-first="2">
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
    [{"author":[{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Doe","given":"John","static-ordering":false},{"family":"Blow","given":"Joe","static-ordering":false},{"family":"Snow","given":"John","static-ordering":false},{"family":"Gogh","given":"Vincent","static-ordering":false}],"id":"ITEM-1","title":"Book A","type":"book"},{"author":[{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Doe","given":"John","static-ordering":false},{"family":"Blow","given":"Joe","static-ordering":false},{"family":"Snow","given":"John","static-ordering":false},{"family":"Bogh","given":"Vincent","static-ordering":false}],"id":"ITEM-2","title":"Book A","type":"book"},{"author":[{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Doe","given":"John","static-ordering":false},{"family":"Blow","given":"Joe","static-ordering":false},{"family":"Snow","given":"John","static-ordering":false},{"family":"Aogh","given":"Vincent","static-ordering":false}],"id":"ITEM-3","title":"Book A","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Roe, Doe, … Aogh, Book A</div>
      <div class="csl-entry">Roe, Doe, … Bogh, Book A</div>
      <div class="csl-entry">Roe, Doe, … Gogh, Book A</div>
    </div>
    """
