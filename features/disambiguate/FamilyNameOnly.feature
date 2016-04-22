Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_FamilyNameOnly to pass

  @citation @disambiguate @citations
  Scenario: Family Name Only
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
      <citation givenname-disambiguation-rule="by-cite" disambiguate-add-givenname="true">
        <layout delimiter="; ">
          <names variable="author">
            <name form="short"/>
          </names>
          <date variable="issued" form="text" date-parts="year"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Blevins"}],"id":"ITEM-1","issued":{"date-parts":[[2001]]},"title":"Book 1","type":"book"},{"author":[{"family":"Blevins"}],"id":"ITEM-2","issued":{"date-parts":[[2001]]},"title":"Book 2","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Blevins2001
    >>[1] Blevins2001
    """
