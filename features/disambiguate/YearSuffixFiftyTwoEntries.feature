Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_YearSuffixFiftyTwoEntries to pass

  @citation @disambiguate @citations
  Scenario: Year Suffix Fifty Two Entries
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
      <citation 
             et-al-min="3"
             et-al-use-first="1"
             disambiguate-add-names="true"
             disambiguate-add-givenname="true"
             disambiguate-add-year-suffix="true"
             givenname-disambiguation-rule="all-names">
        <layout delimiter="; " prefix="(" suffix=")">
          <group delimiter=" ">
            <names delimiter=", " variable="author">
              <name and="symbol" delimiter-precedes-last="never" form="short"/>
            </names>
            <date variable="issued">
              <date-part name="year"/>
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-3","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-4","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-5","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-6","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-7","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-8","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-9","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-10","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-11","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-12","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-13","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-14","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-15","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-16","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-17","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-18","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-19","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-20","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-21","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-22","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-23","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-24","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-25","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-26","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-27","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-28","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-29","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-30","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-31","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-32","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-33","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-34","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-35","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-36","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-37","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-38","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-39","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-40","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-41","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-42","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-43","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-44","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-45","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-46","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-47","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-48","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-49","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-50","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-51","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-52","issued":{"date-parts":[[1986]]},"type":"book"},{"author":[{"family":"Smith","given":"John"}],"id":"ITEM-53","issued":{"date-parts":[[1986]]},"type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] (Smith 1986a; Smith 1986b; Smith 1986c; Smith 1986d; Smith 1986e; Smith 1986f; Smith 1986g; Smith 1986h; Smith 1986i; Smith 1986j; Smith 1986k; Smith 1986l; Smith 1986m; Smith 1986n; Smith 1986o; Smith 1986p; Smith 1986q; Smith 1986r; Smith 1986s; Smith 1986t; Smith 1986u; Smith 1986v; Smith 1986w; Smith 1986x; Smith 1986y; Smith 1986z; Smith 1986aa; Smith 1986ab; Smith 1986ac; Smith 1986ad; Smith 1986ae; Smith 1986af; Smith 1986ag; Smith 1986ah; Smith 1986ai; Smith 1986aj; Smith 1986ak; Smith 1986al; Smith 1986am; Smith 1986an; Smith 1986ao; Smith 1986ap; Smith 1986aq; Smith 1986ar; Smith 1986as; Smith 1986at; Smith 1986au; Smith 1986av; Smith 1986aw; Smith 1986ax; Smith 1986ay)
    >>[1] (Smith 1986az)
    """
