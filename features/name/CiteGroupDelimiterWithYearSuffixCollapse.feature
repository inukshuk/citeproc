Feature: name
  As a CSL cite processor hacker
  I want the test name_CiteGroupDelimiterWithYearSuffixCollapse to pass

  @citation @name @citation-items
  Scenario: Cite Group Delimiter With Year Suffix Collapse
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
      <citation collapse="year-suffix" cite-group-delimiter=", " disambiguate-add-year-suffix="true">
        <layout prefix="(" suffix=")" delimiter="; ">
          <group delimiter=" ">
            <text macro="author"/>
            <date variable="issued" form="text" date-parts="year"/> 
          </group>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <text value="bogus"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-1","issued":{"date-parts":[[2015]]},"type":"book"},{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-2","issued":{"date-parts":[[2015]]},"type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"},{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | (Aalto 2015a, b) |
