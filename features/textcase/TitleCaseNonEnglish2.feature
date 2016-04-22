Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_TitleCaseNonEnglish2 to pass

  @citation @textcase
  Scenario: Title Case Non English2
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          default-locale="de-DE"
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
    [{"id":"ITEM-1","language":"en","title":"Review of book by A.N. author","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Review of Book by A.N. Author
    """
