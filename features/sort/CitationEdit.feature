Feature: sort
  As a CSL cite processor hacker
  I want the test sort_CitationEdit to pass

  @citation @sort @bibentries
  Scenario: Citation Edit
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
      <citation collapse="citation-number">
        <sort>
          <key variable="citation-number" />
        </sort>
        <layout delimiter=", " prefix="[" suffix="]">
          <text variable="citation-number" />
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="citation-number"/>
        </sort>
        <layout>
          <text variable="citation-number"/>
          <text variable="title"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book A","type":"book"},{"id":"ITEM-2","title":"Book B","type":"book"},{"id":"ITEM-3","title":"Book C","type":"book"},{"id":"ITEM-4","title":"Book D","type":"book"}]
    """
    And the following items have been cited:
    """
    ["ITEM-4","ITEM-1","ITEM-2","ITEM-3"]
    """
    When I cite all items
    Then the result should be:
    """
    [1–4]
    """
