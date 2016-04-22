Feature: name
  As a CSL cite processor hacker
  I want the test name_EtAlUseLast to pass

  @bibliography @name
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
      <citation>
        <layout>
          <names variable="author">
            <name />
          </names>
        </layout>
      </citation>
      <bibliography 
          et-al-min="8"
          et-al-use-first="6"
          et-al-use-last="true">
        <layout>
          <names variable="author">
            <name and="text" delimiter-precedes-last="never"/>
          </names>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Anderson","given":"John"},{"family":"Brown","given":"John"},{"family":"Catharsis","given":"John"},{"family":"Doldrums","given":"John"},{"family":"Evergreen","given":"John"},{"family":"Fugedaboutit","given":"John"},{"family":"Gargoyle","given":"John"},{"family":"Houynym","given":"John"}],"id":"ITEM-1","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">John Anderson, John Brown, John Catharsis, John Doldrums, John Evergreen, John Fugedaboutit, … John Houynym</div>
    </div>
    """
