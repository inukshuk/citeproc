Feature: integration
  As a CSL cite processor hacker
  I want the test integration_CrossCitationIbidOnInsert to pass

  @citation @integration @citations
  Scenario: Cross Citation Ibid On Insert
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
      <locale xml:lang="en">
        <terms>
          <term name="ibid">id.</term>
        </terms>
      </locale>
      <citation>
        <layout delimiter="; ">
          <choose>
          <if position="first">
            <group delimiter=", ">
              <text variable="title"/>
              <group delimiter=" ">
                <text variable="volume"/>
                <text variable="container-title"/>
                <text variable="page"/>
                <date variable="issued" prefix="(" suffix=")">
                  <date-part name="year"/>
                </date>
              </group>
            </group>
          </if>
          <else-if position="ibid-with-locator">
            <text term="ibid" suffix=" at "/>
            <text variable="locator"/>
          </else-if>
          <else-if position="ibid">
            <text term="ibid"/>
          </else-if>
          <else-if position="subsequent">
            <group delimiter=", ">
              <text variable="title"/>
              <group delimiter=" ">
                <text variable="volume"/>
                <text variable="container-title"/>
                <choose>
                <if variable="locator">
                  <text variable="locator"/>
                </if>
                <else>
                  <text variable="page"/>
                </else>
                </choose>
               </group>
            </group>
          </else-if>
          <else>
            <text value="WTF?"/>
          </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"U.S.","id":"ITEM-1","issued":{"date-parts":[[2001]]},"page":"23","title":"Doe v. Roe","type":"legal_case","volume":"12"},{"container-title":"L.Ed.","id":"ITEM-2","issued":{"date-parts":[[2001]]},"page":"45","title":"Doe v. Roe","type":"legal_case","volume":"34"},{"container-title":"U.S.","id":"ITEM-3","issued":{"date-parts":[[2002]]},"page":"67","title":"Smith v. Jones","type":"legal_case","volume":"56"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Doe v. Roe, 12 U.S. 23, 34 L.Ed. 45 (2001)
    >>[1] Id. at 78, 34 L.Ed. 89
    ..[2] Smith v. Jones, 56 U.S. 67 (2002)
    """
