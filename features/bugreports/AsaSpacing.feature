Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_AsaSpacing to pass

  @bibliography @bugreports
  Scenario: Asa Spacing
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
      <macro name="title">
        <text variable="title" quotes="true"/> 
      </macro>
      <citation>
        <layout>
          <text value="bogus"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter=" ">
            <text macro="title" suffix="."/>
            <text value="Some text string"/>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"}],"container-title":"His Anonymous Book","id":"ITEM-1","issued":{"date-parts":[["1965","6","1"]]},"page":"100","title":"His Anonymous Chapter","type":"chapter"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">“His Anonymous Chapter.” Some text string</div>
    </div>
    """
