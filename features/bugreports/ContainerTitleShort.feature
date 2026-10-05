Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_ContainerTitleShort to pass

  @bibliography @bugreports @citation-items
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
      <citation>
        <layout>
          <text value="BOGUS"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter="/">
            <text variable="container-title-short"/>
            <text variable="container-title" form="short"/>
            <text variable="container-title"/>
          </group>
        </layout>
      </bibliography></style>
    """
    And the following input:
    """
    [{"container-title":"Anonymous Journal","id":"ITEM-1","journalAbbreviation":"Anon J","type":"article-journal"},{"container-title":"Anonymous Journal One","container-title-short":"Journal-1","id":"ITEM-2","type":"chapter"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Anon J/Anon J/Anonymous Journal</div>
      <div class="csl-entry">Journal-1/Journal-1/Anonymous Journal One</div>
    </div>
    """
