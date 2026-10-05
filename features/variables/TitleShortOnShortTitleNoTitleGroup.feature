Feature: variables
  As a CSL cite processor hacker
  I want the test variables_TitleShortOnShortTitleNoTitleGroup to pass

  @citation @variables @citation-items
  Scenario: Title Short On Short Title No Title Group
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
          <text value="Check this out:"/>
          <group delimiter=" " prefix=" ">
            <text variable="title-short"/>
            <text value="is from title-short"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"My Long Title 1","title-short":"My Short Title","type":"book"},{"id":"ITEM-2","title":"My Long Title 2","type":"book"},{"id":"ITEM-3","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}],[{"id":"ITEM-3"}]]
    """
    Then the results should be:
      | Check this out: My Short Title is from title-short  |
      | Check this out:                                     |
      | Check this out:                                     |
