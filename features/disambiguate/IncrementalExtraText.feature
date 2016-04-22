Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_IncrementalExtraText to pass

  @citation @disambiguate @citations
  Scenario: Incremental Extra Text
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
          <group delimiter=", ">
             <names variable="author">
               <name/>
             </names>
             <choose>
               <if disambiguate="true">
                 <text variable="title"/>
               </if>
             </choose>
             <choose>
               <if disambiguate="true">
                 <group delimiter=" ">
                   <label variable="edition" form="short"/>
                   <number variable="edition"/>
                 </group>
               </if>
             </choose>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Trisk","given":"Yost"}],"id":"ITEM-0","title":"Book One","type":"book"},{"author":[{"family":"Smith","given":"John"}],"edition":"3","id":"ITEM-1","title":"Book One","type":"book"},{"author":[{"family":"Smith","given":"John"}],"edition":"4","id":"ITEM-2","title":"Book Two","type":"book"},{"author":[{"family":"Smith","given":"John"}],"edition":"5","id":"ITEM-3","title":"Complete Works","type":"book"},{"author":[{"family":"Smith","given":"John"}],"edition":"6","id":"ITEM-4","title":"Complete Works","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Yost Trisk
    >>[1] John Smith, Book One
    >>[2] John Smith, Book Two
    >>[3] John Smith, Complete Works, ed. 5
    >>[4] John Smith, Complete Works, ed. 6
    """
