Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_TitleCaseWithFinalNocase to pass

  @citation @textcase
  Scenario: Title Case With Final Nocase
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
          <text variable="title" text-case="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"The <span class=\"nocase\">Mirror</span>, the <span class=\"nocase\">Window</span>, and the <span class=\"nocase\">Telescope</span>: <span class=\"nocase\">How Renaissance Linear Perspective Changed Our Vision</span> of the <span class=\"nocase\">Universe</span>","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    The Mirror, the Window, and the Telescope: How Renaissance Linear Perspective Changed Our Vision of the Universe
    """
