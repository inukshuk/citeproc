Feature: name
  As a CSL cite processor hacker
  I want the test name_EditorTranslatorSameWithTerm to pass

  @citation @name
  Scenario: Editor Translator Same With Term
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
          <names variable="editor translator" delimiter=", ">
            <name />
            <label form="short" prefix=" (" suffix=")"/>
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
    John Doe (ed. &amp; tran.)
    """
