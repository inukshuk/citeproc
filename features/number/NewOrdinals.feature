Feature: number
  As a CSL cite processor hacker
  I want the test number_NewOrdinals to pass

  @citation @number @citations
  Scenario: New Ordinals
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
      <locale locale="en">
        <terms>
          <!-- ORDINALS -->
          <term name="ordinal">th-default</term>
          <term name="ordinal-00" match="last-digit">th-zero</term>
          <term name="ordinal-01" match="whole-number">st-one</term>
          <term name="ordinal-02" match="last-digit">nd-two-end</term>
          <term name="ordinal-03" match="last-digit">rd-three-end</term>
          <term name="ordinal-04">th</term>
          <term name="ordinal-12" match="whole-number">th-twelve</term>
          <term name="ordinal-13" match="last-two-digits">th-thirteen-end</term>
        </terms>
      </locale>
      <citation>
        <layout delimiter="; ">
          <group delimiter=": ">
            <text variable="title"/>
            <number variable="edition" form="ordinal"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"edition":1,"id":"ITEM-1","title":"Title 1","type":"book"},{"edition":2,"id":"ITEM-2","title":"Title 2","type":"book"},{"edition":3,"id":"ITEM-3","title":"Title 3","type":"book"},{"edition":4,"id":"ITEM-4","title":"Title 4","type":"book"},{"edition":5,"id":"ITEM-5","title":"Title 5","type":"book"},{"edition":10,"id":"ITEM-10","title":"Title 10","type":"book"},{"edition":11,"id":"ITEM-11","title":"Title 11","type":"book"},{"edition":12,"id":"ITEM-12","title":"Title 12","type":"book"},{"edition":13,"id":"ITEM-13","title":"Title 13","type":"book"},{"edition":14,"id":"ITEM-14","title":"Title 14","type":"book"},{"edition":110,"id":"ITEM-110","title":"Title 110","type":"book"},{"edition":111,"id":"ITEM-111","title":"Title 111","type":"book"},{"edition":112,"id":"ITEM-112","title":"Title 112","type":"book"},{"edition":113,"id":"ITEM-113","title":"Title 113","type":"book"},{"edition":114,"id":"ITEM-114","title":"Title 114","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Title 1: 1st-one
    ..[1] Title 2: 2nd-two-end
    ..[2] Title 3: 3rd-three-end
    ..[3] Title 4: 4th
    ..[4] Title 5: 5th-default
    ..[5] Title 10: 10th-zero
    ..[6] Title 11: 11th-default
    ..[7] Title 12: 12th-twelve
    ..[8] Title 13: 13th-thirteen-end
    ..[9] Title 14: 14th
    ..[10] Title 110: 110th-zero
    ..[11] Title 111: 111th-default
    ..[12] Title 112: 112nd-two-end
    ..[13] Title 113: 113th-thirteen-end
    >>[14] Title 114: 114th
    """
