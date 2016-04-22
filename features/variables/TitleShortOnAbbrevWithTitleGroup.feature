Feature: variables
  As a CSL cite processor hacker
  I want the test variables_TitleShortOnAbbrevWithTitleGroup to pass

  @citation @variables @citations
  Scenario: Title Short On Abbrev With Title Group
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
    [{"id":"ITEM-1","title":"My Long Title 1","type":"book"},{"id":"ITEM-2","title":"My Long Title 2","type":"book"},{"id":"ITEM-3","type":"book"}]
    """
    And the following abbreviations:
    """
    {"default":{"title":{"My Long Title 1":"My Short Title"}}}
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] Check this out: My Short Title is from title-short
    ..[1] Check this out:
    >>[2] Check this out:
    """
