Feature: api
  As a CSL cite processor hacker
  I want the test api_SuppressAuthor to pass

  @citation @api @citations
  Scenario: Suppress Author
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
           <group delimiter="+">
             <names variable="author">
               <name form="short" />
               <label prefix=" (" suffix=")"/>
             </names>
             <names variable="editor">
               <name form="short" />
               <label prefix=" (" suffix=")"/>
             </names>
             <names variable="translator">
               <name form="short" />
               <label prefix=" (" suffix=")"/>
             </names>
           </group>
         </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Alan"}],"editor":[{"family":"Blevins","given":"Butthead"}],"id":"ITEM-1","type":"book"},{"editor":[{"family":"Colostomy","given":"Colin"}],"id":"ITEM-2","translator":[{"family":"Dropsie","given":"David"}],"type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Blevins (editor)
    >>[1] Dropsie (translator)
    """
