Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_AndreaEg4 to pass

  @citation @disambiguate @citation-items
  Scenario: Andrea Eg4
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
      <macro name="year">
        <date variable="issued" date-parts="year" form="text"/>
      </macro>
      <citation 
             et-al-min="3"
             et-al-use-first="1"
             disambiguate-add-names="true"
             disambiguate-add-givenname="true"
    	 givenname-disambiguation-rule="by-cite">
    
        <layout delimiter="; ">
          <group delimiter=" ">
            <names delimiter=", " variable="author">
              <name initialize-with=". " and="symbol" delimiter-precedes-last="never" form="short"/>
            </names>
            <date variable="issued" prefix="(" suffix=")">
              <date-part name="year"/>
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"John"},{"family":"Brown","given":"John"},{"family":"Jones","given":"John"}],"id":"ITEM-1","issued":{"date-parts":[[1980]]},"type":"book"},{"author":[{"family":"Smith","given":"John"},{"family":"Brown","given":"John"},{"family":"Jones","given":"John"}],"id":"ITEM-2","issued":{"date-parts":[[1980]]},"type":"book"},{"author":[{"family":"Smith","given":"John"},{"family":"Benson","given":"John"},{"family":"Jones","given":"John"}],"id":"ITEM-3","issued":{"date-parts":[[1980]]},"type":"book"},{"author":[{"family":"Smith","given":"John"},{"family":"Brown","given":"John"},{"family":"Jones","given":"Alan"}],"id":"ITEM-4","issued":{"date-parts":[[1980]]},"type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"},{"id":"ITEM-2"}],[{"id":"ITEM-1"},{"id":"ITEM-3"}],[{"id":"ITEM-1"},{"id":"ITEM-4"}]]
    """
    Then the results should be:
      | Smith, Brown &amp; J. Jones (1980); Smith, Brown &amp; J. Jones (1980)  |
      | Smith, Brown &amp; J. Jones (1980); Smith, Benson, et al. (1980)        |
      | Smith, Brown &amp; J. Jones (1980); Smith, Brown &amp; A. Jones (1980)  |
