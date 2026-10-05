Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_TitleCaseWithVolumeTitle to pass

  @bibliography @textcase
  Scenario: Title Case With Volume Title
    Given the following style:
    """
    <style
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2025-03-12T12:22:26+00:00</updated>
      </info>
      <citation>
        <layout delimiter="; ">
          <text value="DUMMY"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <text text-case="title" variable="event-title"/>
          <text text-case="title" variable="original-title"/>
          <text text-case="title" variable="part-title"/>
          <text text-case="title" variable="reviewed-title"/>
          <text text-case="title" variable="volume-title"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"event-title":"Syntax und Stilistik","id":"ITEM-1","language":"de","type":"book"},{"id":"ITEM-2","language":"de","original-title":"Syntax und Stilistik","type":"book"},{"id":"ITEM-3","language":"de","part-title":"Syntax und Stilistik","type":"book"},{"id":"ITEM-4","language":"de","reviewed-title":"Syntax und Stilistik","type":"book"},{"id":"ITEM-5","language":"de","type":"book","volume-title":"Syntax und Stilistik"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Syntax und Stilistik</div>
      <div class="csl-entry">Syntax und Stilistik</div>
      <div class="csl-entry">Syntax und Stilistik</div>
      <div class="csl-entry">Syntax und Stilistik</div>
      <div class="csl-entry">Syntax und Stilistik</div>
    </div>
    """
