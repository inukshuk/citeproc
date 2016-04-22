Feature: number
  As a CSL cite processor hacker
  I want the test number_PlainHyphenOrEnDashAlwaysPlural to pass

  @citation @number
  Scenario: Plain Hyphen Or En Dash Always Plural
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
          <group delimiter=" " suffix=" (cs:text)">
            <text variable="title"/>
            <label variable="page"/>
            <text variable="page"/>
          </group>
          <group delimiter=" " prefix=" vs " suffix=" (cs:number)">
            <text variable="title"/>
            <label variable="page"/>
            <text variable="page"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"1-2","title":"His Anonymous Life (1)","type":"book"},{"id":"ITEM-2","page":"i-ix","title":"His Anonymous Life (2)","type":"book"},{"id":"ITEM-3","page":"3\\-B","title":"His Anonymous Life (3)","type":"book"},{"id":"ITEM-4","page":"4–6","title":"His Anonymous Life (4)","type":"book"},{"id":"ITEM-4","page":"Michaelson-Morely","title":"His Anonymous Life (4)","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    His Anonymous Life (1) pages 1–2 (cs:text) vs His Anonymous Life (1) pages 1–2 (cs:number); His Anonymous Life (2) pages i–ix (cs:text) vs His Anonymous Life (2) pages i–ix (cs:number); His Anonymous Life (3) page 3-B (cs:text) vs His Anonymous Life (3) page 3-B (cs:number); His Anonymous Life (4) page Michaelson–Morely (cs:text) vs His Anonymous Life (4) page Michaelson–Morely (cs:number)
    """
