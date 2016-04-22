Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_ItalicsSimple to pass

  @citation @flipflop @citation-items
  Scenario: Italics Simple
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
          <text variable="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"One TwoA <i>Three Four</i> Five!","type":"book"},{"id":"ITEM-2","title":"<i>One TwoB</i> Three Four Five!","type":"book"},{"id":"ITEM-3","title":"One TwoC Three <i>Four Five!</i>","type":"book"},{"id":"ITEM-4","title":"<i>One TwoD</i> Three <i>Four Five!</i>","type":"book"},{"id":"ITEM-5","title":"<i>One TwoE <i>Three</i> Four Five!</i>","type":"book"},{"id":"ITEM-6","title":"One TwoF</i> Three Four Five!","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}],[{"id":"ITEM-3"}],[{"id":"ITEM-4"}],[{"id":"ITEM-5"}],[{"id":"ITEM-6"}]]
    """
    Then the results should be:
      | One TwoA <i>Three Four</i> Five!      |
      | <i>One TwoB</i> Three Four Five!      |
      | One TwoC Three <i>Four Five!</i>      |
      | <i>One TwoD</i> Three <i>Four Five!</i> |
      | <i>One TwoE <span style="font-style:normal;">Three</span> Four Five!</i> |
      | One TwoF&#60;/i&#62; Three Four Five! |
