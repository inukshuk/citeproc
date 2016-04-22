Feature: page
  As a CSL cite processor hacker
  I want the test page_NoOption to pass

  @citation @page
  Scenario: No Option
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
          <text variable="title"/>
          <text variable="page" prefix=", at "/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"110-5","title":"Book Thing","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Book Thing, at 110–5
    """
