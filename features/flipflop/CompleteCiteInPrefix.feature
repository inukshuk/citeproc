Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_CompleteCiteInPrefix to pass

  @citation @flipflop @citation-items
  Scenario: Complete Cite In Prefix
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
          <text variable="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Other Book Title","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","prefix":"Wilhelm Dilthey, \"The Types of World Views and Their Unfoldment Within the Metaphysical Systems,\" in <i>Dilthey’s Philosophy of Existence: Introduction to Weltanschauungslehre</i>, trans. William Kluback and Martin Weinbaum (New York: Bookman Associates, 1957), 26–27 "}]]
    """
    Then the results should be:
      | Wilhelm Dilthey, “The Types of World Views and Their Unfoldment Within the Metaphysical Systems,” in <i>Dilthey’s Philosophy of Existence: Introduction to Weltanschauungslehre</i>, trans. William Kluback and Martin Weinbaum (New York: Bookman Associates, 1957), 26–27 Other Book Title |
