Feature: affix
  As a CSL cite processor hacker
  I want the test affix_WordProcessorAffixNoSpace to pass

  @citation @affix @citations
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
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] <i>My Prefix</i> My Title My Suffix
    ..[1] My Prefix. My Title, My Suffix
    >>[2] My Prefix My Title My Suffix
    """
