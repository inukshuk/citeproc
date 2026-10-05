Feature: label
  As a CSL cite processor hacker
  I want the test label_CollapsedPageNumberPluralDetection to pass

  @citation @label @citation-items
  Scenario: Collapsed Page Number Plural Detection
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          page-range-format="expanded">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
         <group delimiter=", ">
           <text variable="title"/>
           <group delimiter=" ">
             <label variable="locator"/>
             <text variable="locator"/>
           </group>
         </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"His Anonymous Life","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","label":"page","locator":"327\\-30"}],[{"id":"ITEM-1","label":"page","locator":"427-30"}]]
    """
    Then the results should be:
      | His Anonymous Life, page 327-30   |
      | His Anonymous Life, pages 427–430 |
