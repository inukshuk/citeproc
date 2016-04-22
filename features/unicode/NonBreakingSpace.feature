Feature: unicode
  As a CSL cite processor hacker
  I want the test unicode_NonBreakingSpace to pass

  @citation @unicode
  Scenario: Non Breaking Space
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
          <text variable="title" suffix="&#x00A0;" />
          <text value="(postfix following non-breaking space)" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    His Anonymous Life (postfix following non-breaking space)
    """
