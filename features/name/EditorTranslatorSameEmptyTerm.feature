Feature: name
  As a CSL cite processor hacker
  I want the test name_EditorTranslatorSameEmptyTerm to pass

  @citation @name
  Scenario: Editor Translator Same Empty Term
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
      <locale>
        <terms>
          <term name="editortranslator"></term>
        </terms>
      </locale>
      <citation>
        <layout>
          <names variable="editor translator" delimiter=", ">
            <name />
            <label prefix=" (" suffix=")"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"editor":[{"family":"Doe","given":"John"}],"id":"ITEM-1","translator":[{"family":"Doe","given":"John"}],"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John Doe (editor), John Doe (translator)
    """
