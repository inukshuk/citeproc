Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_CapitalsUntouched to pass

  @citation @textcase
  Scenario: Capitals Untouched
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
        <layout delimiter="&#x0A;">
          <text variable="title" text-case="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"UK","type":"book"},{"id":"ITEM-2","title":"Review of Book by A.N. Author","type":"book"},{"id":"ITEM-3","title":"Writings on UK people and places","type":"book"},{"id":"ITEM-4","title":"All for one. For all.","type":"book"},{"id":"ITEM-5","title":"OC 1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    UK
    Review of Book by A.N. Author
    Writings on UK People and Places
    All for One. For All.
    OC 1
    """
