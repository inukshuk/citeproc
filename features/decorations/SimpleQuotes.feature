Feature: decorations
  As a CSL cite processor hacker
  I want the test decorations_SimpleQuotes to pass

  @citation @decorations
  Scenario: Simple Quotes
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
          <text quotes="true" value="My title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"item-1","title":"Ignore me","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    “My title”
    """
