Feature: number
  As a CSL cite processor hacker
  I want the test number_MixedText to pass

  @citation @number
  Scenario: Mixed Text
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
          <number variable="edition"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"edition":"5 ed.","id":"ITEM-1","type":"book"},{"edition":"5 edition","id":"ITEM-2","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    5 ed.; 5 edition
    """
