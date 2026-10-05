Feature: label
  As a CSL cite processor hacker
  I want the test label_EditorTranslator2 to pass

  @citation @label @citation-items
  Scenario: Editor Translator2
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
          <text variable="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Some title","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","suffix":", \"Hello there\"."}]]
    """
    Then the results should be:
      | Some title, “Hello there”. |
