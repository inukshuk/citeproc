Feature: name
  As a CSL cite processor hacker
  I want the test name_ArabicShortForms to pass

  @citation @name @citation-items
  Scenario: Arabic Short Forms
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
      <macro name="author">
        <names variable="author">
          <name form="short" />
        </names>
      </macro>
      <citation>
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"al-Aswānī","given":"ʿAlāʾ"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"al-Aswānī","given":"`Alā'"}],"id":"ITEM-2","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"},{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | al-Aswānī; al-Aswānī |
