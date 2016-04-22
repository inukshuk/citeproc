Feature: group
  As a CSL cite processor hacker
  I want the test group_SuppressValueWithEmptySubgroup to pass

  @citation @group
  Scenario: Suppress Value With Empty Subgroup
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
          <group prefix=", ">
             <text value="Disponible sur : " prefix=" "/>
             <group prefix="&lt; " suffix=" &gt;">
                <choose>
                   <if variable="DOI">
                      <text variable="DOI"/>
                   </if>
                   <else>
                      <text variable="URL"/>
                   </else>
                </choose>
             </group>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    His Anonymous Life
    """
