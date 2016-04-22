Feature: virtual
  As a CSL cite processor hacker
  I want the test virtual_PageFirst to pass

  @citation @virtual
  Scenario: Page First
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
      <macro name="page-first">
        <text variable="page-first"/>
      </macro>
      <citation>
        <layout>
    	  <text variable="page-first" suffix=":"/>
          <text macro="page-first"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"12-20","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    12:12
    """
