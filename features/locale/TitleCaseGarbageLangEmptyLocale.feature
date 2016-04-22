Feature: locale
  As a CSL cite processor hacker
  I want the test locale_TitleCaseGarbageLangEmptyLocale to pass

  @citation @locale
  Scenario: Title Case Garbage Lang Empty Locale
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
          <text variable="title" text-case="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","language":"fr French language","title":"His anonymous life","type":"book"},{"id":"ITEM-2","language":"en--other stuff commenting about the lingo","title":"His anonymous life","type":"book"},{"id":"ITEM-3","language":"french language","title":"His anonymous life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    His anonymous life; His Anonymous Life; His anonymous life
    """
