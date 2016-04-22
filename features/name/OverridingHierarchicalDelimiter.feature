Feature: name
  As a CSL cite processor hacker
  I want the test name_OverridingHierarchicalDelimiter to pass

  @citation @name
  Scenario: Overriding Hierarchical Delimiter
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          name-delimiter="/">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation name-delimiter="//">
        <layout>
          <names variable="author">
            <name delimiter="///"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"}],"id":"item-1","title":"Our Anonymous Lives","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John Doe///Jane Roe
    """
