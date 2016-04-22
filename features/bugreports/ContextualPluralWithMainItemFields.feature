Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_ContextualPluralWithMainItemFields to pass

  @citation @bugreports
  Scenario: Contextual Plural With Main Item Fields
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
        <layout delimiter="; ">
    	  <label variable="page" suffix=" "/>
          <text variable="page" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","page":"1 & 2","type":"book"},{"id":"ITEM-2","page":"1, 2","type":"book"},{"id":"ITEM-3","page":"1-2","type":"book"},{"id":"ITEM-4","page":"1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    pages 1 &amp; 2; pages 1, 2; pages 1–2; page 1
    """
