Feature: name
  As a CSL cite processor hacker
  I want the test name_InstitutionDecoration to pass

  @citation @name
  Scenario: Institution Decoration
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
          <names variable="author">
            <name name-as-sort-order="all" sort-separator=", " initialize-with=". " delimiter="; " delimiter-precedes-last="always">
             <name-part name="given" text-case="uppercase"/>
             <name-part name="family" text-case="uppercase"/>
            </name>
            <et-al prefix=" " font-style="italic"/>
            <label form="short" prefix=" (" suffix=".)" text-case="uppercase"/>
            <substitute>
              <names variable="editor"/>
              <names variable="translator"/>
              <text variable="title"/>
            </substitute>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"literal":"São Paulo (Estado)"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    SÃO PAULO (ESTADO)
    """
