Feature: sort
  As a CSL cite processor hacker
  I want the test sort_CitationNumberPrimaryAscendingViaVariableBibliography to pass

  @bibliography @sort
  Scenario: Citation Number Primary Ascending Via Variable Bibliography
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
        <sort>
          <key variable="citation-number"/>
        </sort>
        <layout>
          <group delimiter=" ">
            <number variable="citation-number" prefix="[" suffix="]"/>
            <text variable="title"/>
          </group>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="citation-number" sort="ascending"/>
        </sort>
        <layout>
          <text variable="citation-number" prefix="[" suffix="] "/>
          <text variable="title" />
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"item-1","title":"Aaaa (first-cited)","type":"book"},{"id":"item-2","title":"Bbbb (second-cited)","type":"book"},{"id":"item-3","title":"Zzzz (third-cited)","type":"book"},{"id":"item-4","title":"Xxxx (fourth-cited)","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">[1] Aaaa (first-cited)</div>
      <div class="csl-entry">[2] Bbbb (second-cited)</div>
      <div class="csl-entry">[3] Zzzz (third-cited)</div>
      <div class="csl-entry">[4] Xxxx (fourth-cited)</div>
    </div>
    """
