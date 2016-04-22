Feature: bibsection
  As a CSL cite processor hacker
  I want the test bibsection_Include to pass

  @bibliography @bibsection
  Scenario: Include
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
      <citation>
        <layout>
          <text value="Oops"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="title" />
        </sort>
        <layout>
          <text variable="title" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book C","type":"book"},{"id":"ITEM-2","title":"Article B","type":"article-journal"},{"id":"ITEM-3","title":"Book A","type":"book"}]
    """
    When I render the following bibliography selection:
    """
    {"include":[{"field":"type","value":"book"}]}
    """
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Book A</div>
      <div class="csl-entry">Book C</div>
    </div>
    """
