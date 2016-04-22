Feature: bibheader
  As a CSL cite processor hacker
  I want the test bibheader_SecondFieldAlignWithNumber to pass

  @bibliography-header @bibheader
  Scenario: Second Field Align With Number
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
      <macro name="elaborate-citation-number">
        <text variable="citation-number" prefix="[" suffix="]"/>
      </macro>
      <citation>
        <layout>
    	  <text variable="title"/>
        </layout>
      </citation>
      <bibliography second-field-align="flush">
        <layout>
          <text macro="elaborate-citation-number"/>
    	  <names variable="author">
    	    <name initialize-with=". " name-as-sort-order="all" sort-separator=", "/>
          </names>
          <text variable="title"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Hodgins","given":"Christopher"}],"container-title":"Big Series","id":"ITEM-1","title":"One","type":"book"},{"author":[{"family":"Smith","given":"John"}],"container-title":"Big Series","id":"ITEM-2","title":"One+","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography's options should match:
      | entry-spacing | line-spacing |
      | 1             | 1            |
