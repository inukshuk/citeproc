Feature: name
  As a CSL cite processor hacker
  I want the test name_ApostropheInGivenName to pass

  @citation @name @citation-items
  Scenario: Apostrophe In Given Name
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
          <name form="long" />
        </names>
      </macro>
      <citation>
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Shun'ichi"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | Shun’ichi Aalto |
