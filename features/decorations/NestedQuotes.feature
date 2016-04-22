Feature: decorations
  As a CSL cite processor hacker
  I want the test decorations_NestedQuotes to pass

  @citation @decorations
  Scenario: Nested Quotes
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
          <text quotes="true" variable="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"item-1","title":"My “Amazing” Title","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    “My ‘Amazing’ Title”
    """
