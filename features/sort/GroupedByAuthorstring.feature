Feature: sort
  As a CSL cite processor hacker
  I want the test sort_GroupedByAuthorstring to pass

  @citation @sort @citations
  Scenario: Grouped By Authorstring
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="in-text"
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
      <citation collapse="year-suffix"
        et-al-min="3"
        et-al-use-first="1"
        et-al-subsequent-min="3"
        et-al-subsequent-use-first="1"
        disambiguate-add-year-suffix="true">
        <sort>
          <key variable="issued" />
        </sort>
        <layout delimiter="; ">
          <group delimiter=" ">
            <text macro="author"/>
            <date variable="issued" form="text" date-parts="year"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[[2010]]},"type":"book"},{"author":[{"family":"Jones","given":"2005"}],"id":"ITEM-2","issued":{"date-parts":[[2005]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-3","issued":{"date-parts":[[2003]]},"type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] Smith 2003, 2010; Jones 2005
    """
