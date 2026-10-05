Feature: sort
  As a CSL cite processor hacker
  I want the test sort_OmittedBibRefMixedNumericStyle to pass

  @bibliography @sort @citation-items
  Scenario: Omitted Bib Ref Mixed Numeric Style
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
      <macro name="author">
        <names variable="author">
          <name form="short" />
        </names>
      </macro>
      <citation>
        <sort>
          <key variable="citation-number"/>
        </sort>
        <layout prefix="(" suffix=")" delimiter="; ">
          <choose>
            <if type="personal_communication">
              <group delimiter=", ">
                <text macro="author" />
                <text variable="title"/>
              </group>
            </if>
            <else>
              <text variable="citation-number"/>
            </else>
          </choose>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <choose>
            <if match="none" type="personal_communication">
              <group delimiter=". ">
                <text variable="citation-number"/>
                <group delimiter=", ">
                  <text macro="author" />
                  <text variable="title"/>
                </group>
              </group>
            </if>
          </choose>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Anderson","given":"Andrew"}],"id":"ITEM-1","title":"Book One","type":"book"},{"author":[{"family":"Brown","given":"Burt"}],"id":"ITEM-2","title":"Letter One","type":"personal_communication"},{"author":[{"family":"Crane","given":"Clive"}],"id":"ITEM-3","title":"Book Two","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">1. Anderson, Book One</div>
      <div class="csl-entry">2. [CSL STYLE ERROR: reference with no printed form.]</div>
      <div class="csl-entry">3. Crane, Book Two</div>
    </div>
    """
