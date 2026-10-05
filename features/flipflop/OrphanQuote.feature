Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_OrphanQuote to pass

  @citation @flipflop @citation-items
  Scenario: Orphan Quote
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
        <layout delimiter="; ">
          <text variable="title" text-case="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Nation of \"Positive Obligations \" of State under the European Convention on Human Rights (1)","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | Nation of "Positive Obligations " of State under the European Convention on Human Rights (1) |
