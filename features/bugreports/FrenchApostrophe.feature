Feature: bugreports
  As a CSL cite processor hacker
  I want the test bugreports_FrenchApostrophe to pass

  @citation @bugreports
  Scenario: French Apostrophe
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          default-locale="fr-FR">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation>
        <layout>
          <text variable="title" quotes="true"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Life's 'Little' Surprises","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    « Life’s “Little” Surprises »
    """
