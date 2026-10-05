Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_DisambiguateTrueReflectedInBibliography to pass

  @bibliography @disambiguate @citation-items
  Scenario: Disambiguate True Reflected In Bibliography
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
        <layout delimiter="; ">
          <group delimiter=", ">
            <text macro="author" />
            <choose>
              <if disambiguate="true">
                <text variable="title"/>
              </if>
            </choose>
          </group>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter=", ">
            <text macro="author" />
            <choose>
              <if disambiguate="true">
                <text variable="title"/>
              </if>
            </choose>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"Alan"}],"id":"ITEM-1","title":"Book One","type":"book"},{"author":[{"family":"Smith","given":"Alan"}],"id":"ITEM-2","title":"Book Two","type":"book"},{"author":[{"family":"Brown","given":"Cadbury"}],"id":"ITEM-3","title":"Book the X","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Smith, Book One</div>
      <div class="csl-entry">Smith, Book Two</div>
      <div class="csl-entry">Brown</div>
    </div>
    """
