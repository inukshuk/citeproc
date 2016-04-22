Feature: position
  As a CSL cite processor hacker
  I want the test position_IbidWithPrefixFullStop to pass

  @citation @position @citations
  Scenario: Ibid With Prefix Full Stop
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
      <locale>
       <style-options punctuation-in-quote="true"/>
      </locale>
      <citation>
        <layout delimiter="; ">
          <choose>
            <if position="subsequent">
              <text term="ibid"/>
            </if>
            <else>
              <text variable="title"/>
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Book A","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Book A. He said “Please work.” Ibid.
    """
