Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_LeadingMarkupWithApostrophe to pass

  @citation @flipflop @citation-items
  Scenario: Leading Markup With Apostrophe
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
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","prefix":"<i>Insha’Allah</i> is an Arabic phrase meaning ‘God willing’. Another Arabic word is <i>bukra</i>. "}]]
    """
    Then the results should be:
      | <i>Insha’Allah</i> is an Arabic phrase meaning ‘God willing’. Another Arabic word is <i>bukra</i>. Aalto |
