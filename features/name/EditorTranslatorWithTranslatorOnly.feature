Feature: name
  As a CSL cite processor hacker
  I want the test name_EditorTranslatorWithTranslatorOnly to pass

  @citation @name
  Scenario: Editor Translator With Translator Only
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
          <names variable="editor translator">
            <name/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","translator":[{"family":"Roe","given":"Jane"}],"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Jane Roe
    """
