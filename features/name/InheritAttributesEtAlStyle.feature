Feature: name
  As a CSL cite processor hacker
  I want the test name_InheritAttributesEtAlStyle to pass

  @citation @name
  Scenario: Inherit Attributes Et Al Style
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          et-al-min="3"
          et-al-use-first="2">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <names variable="author">
            <name delimiter=", " form="short"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"},{"family":"Noakes","given":"John"},{"family":"Stoakes","given":"Richard"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Doe, Roe, et al.
    """
