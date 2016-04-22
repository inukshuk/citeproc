Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_SkipNameParticlesInTitleCase to pass

  @citation @textcase @non-standard
  Scenario: Skip Name Particles In Title Case
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
    [{"id":"ITEM-1","title":"John von Doe: an about up life","type":"book"},{"id":"ITEM-4","title":"John van Doe? a life","type":"book"},{"id":"ITEM-2","title":"John d'Doe! a life","type":"book"},{"id":"ITEM-3","title":"John de Doe a life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John von Doe: An about up Life; John van Doe? A Life; John d’Doe! A Life; John de Doe a Life
    """
