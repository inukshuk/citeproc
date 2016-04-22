Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_StartingApostrophe to pass

  @citation @flipflop
  Scenario: Starting Apostrophe
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
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"title":"IEEE Conference on Emerging Technologies and Factory Automation (ETFA '09)","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    IEEE Conference on Emerging Technologies and Factory Automation (ETFA ’09)
    """
