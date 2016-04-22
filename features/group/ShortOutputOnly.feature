Feature: group
  As a CSL cite processor hacker
  I want the test group_ShortOutputOnly to pass

  @citation @group
  Scenario: Short Output Only
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
          <group>
    		<text variable="title" form="short"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"my container title","id":"ITEM-1","shortTitle":"something","type":"manuscript"}]
    """
    When I cite all items
    Then the result should be:
    """
    something
    """
