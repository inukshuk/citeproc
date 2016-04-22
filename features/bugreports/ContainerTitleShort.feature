Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_ContainerTitleShort to pass

  @citation @bugreports
  Scenario: Container Title Short
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
      <macro name="container-title">
        <group>
          <choose>
            <if type="article-journal">
              <text variable="container-title" form="short" strip-periods="true"/>
            </if>
            <else>
              <text variable="container-title" form="short"/>
            </else>
          </choose>
        </group>
      </macro>
      <citation>
        <layout>
          <text macro="container-title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"Anonymous Journal","id":"ITEM-1","journalAbbreviation":"Anon. J.","type":"article-journal"}]
    """
    When I cite all items
    Then the result should be:
    """
    Anon J
    """
