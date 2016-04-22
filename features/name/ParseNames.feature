Feature: name
  As a CSL cite processor hacker
  I want the test name_ParseNames to pass

  @citation @name
  Scenario: Parse Names
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          demote-non-dropping-particle="sort-only">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <sort>
          <key variable="author"/>
        </sort>
        <layout delimiter="; ">
          <names variable="author">
            <name name-as-sort-order="all" sort-separator=", "/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"van der Vlist","given":"Eric"}],"id":"ITEM-3","type":"book"},{"author":[{"family":"van Gogh","given":"Vincent","parse-names":true}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Humboldt","given":"Alexander von","parse-names":true}],"id":"ITEM-2","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    van Gogh, Vincent; Humboldt, Alexander von; van der Vlist, Eric
    """
