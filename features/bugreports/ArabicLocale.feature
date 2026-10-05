Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_ArabicLocale to pass

  @citation @bugreports @citation-items
  Scenario: Arabic Locale
    Given the following style:
    """
    <?xml version="1.0" encoding="utf-8"?>
    <style xmlns="http://purl.org/net/xbiblio/csl" class="note" version="1.0" default-locale="ar">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout suffix="." delimiter="; ">
          <names variable="author">
            <name et-al-use-first="1" et-al-min="3"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Chang","given":"Jonathan"},{"family":"Gerrish","given":"Sean"},{"family":"Wang","given":"Chong"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | Jonathan Chang وآخرون. |
