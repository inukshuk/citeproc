Feature: name
  As a CSL cite processor hacker
  I want the test name_AndTextDelimiterPrecedesLastAlways to pass

  @citation @name
  Scenario: And Text Delimiter Precedes Last Always
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
            <name and="text" delimiter="; " initialize-with="." name-as-sort-order="all" delimiter-precedes-last="always"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"},{"family":"Noakes","given":"Richard"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Doe, J.; Roe, J.; and Noakes, R.
    """
