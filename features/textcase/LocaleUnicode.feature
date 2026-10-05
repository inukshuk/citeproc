Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_LocaleUnicode to pass

  @citation @textcase @citation-items
  Scenario: Locale Unicode
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          default-locale="en"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <text variable="title" text-case="uppercase"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"ia and ıb EN","type":"book"},{"id":"ITEM-2","language":"en","title":"ia and ıb EN","type":"book"},{"id":"ITEM-3","language":"tr","title":"ic and ıd TR","type":"book"},{"id":"ITEM-4","language":"original-one hello","title":"bad language code that passes in node.js but fails in some browsers","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}],[{"id":"ITEM-3"}],[{"id":"ITEM-4"}]]
    """
    Then the results should be:
      | IA AND IB EN  |
      | IA AND IB EN  |
      | İC AND ID TR  |
      | BAD LANGUAGE CODE THAT PASSES IN NODE.JS BUT FAILS IN SOME BROWSERS |
