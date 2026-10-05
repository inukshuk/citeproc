Feature: sort
  As a CSL cite processor hacker
  I want the test sort_DaleDalebout to pass

  @bibliography @sort @citation-items
  Scenario: Dale Dalebout
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
      <macro name="author">
        <names variable="author">
          <name form="short" />
        </names>
      </macro>
      <citation>
        <sort>
          <key macro="author" />
        </sort>
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author" />
        </sort>
        <layout>
          <text macro="author" />
          <text variable="title"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Dale","given":"Zippy"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Dalebout","given":"Arnie"}],"id":"ITEM-3","type":"book"},{"author":[{"family":"Allabout","given":"Kelly"}],"id":"ITEM-2","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Allabout</div>
      <div class="csl-entry">Dale</div>
      <div class="csl-entry">Dalebout</div>
    </div>
    """
