Feature: bibheader
  As a CSL cite processor hacker
  I want the test bibheader_EntryspacingDefaultValueOne to pass

  @bibliography-header @bibheader
  Scenario: Entryspacing Default Value One
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
    	  <text variable="title"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <text variable="title"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"One","type":"book"},{"id":"ITEM-2","title":"Two","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography's options should match:
      | entry-spacing | line-spacing |
      | 1             | 1            |
