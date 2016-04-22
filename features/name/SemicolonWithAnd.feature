Feature: name
  As a CSL cite processor hacker
  I want the test name_SemicolonWithAnd to pass

  @citation @name
  Scenario: Semicolon With And
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
          <names variable="author">
            <name and="text" 
                  delimiter-precedes-last="always" 
                  initialize-with="."
                  delimiter="; "/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Smith","given":"Cecil"},{"family":"Brown","given":"Jimminey"},{"family":"Wilson","given":"Fred"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    C. Smith; J. Brown; and F. Wilson
    """
