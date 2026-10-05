Feature: affix
  As a CSL cite processor hacker
  I want the test affix_WordProcessorAffixNoSpace to pass

  @citation @affix @citation-items
  Scenario: Word Processor Affix No Space
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
        <layout>
          <text variable="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"My Title","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","prefix":"<i>My Prefix</i> ","suffix":" My Suffix"}],[{"id":"ITEM-1","prefix":"My Prefix. ","suffix":", My Suffix"}],[{"id":"ITEM-1","prefix":"My Prefix ","suffix":" My Suffix"}]]
    """
    Then the results should be:
      | <i>My Prefix</i> My Title My Suffix |
      | My Prefix. My Title, My Suffix  |
      | My Prefix My Title My Suffix    |
