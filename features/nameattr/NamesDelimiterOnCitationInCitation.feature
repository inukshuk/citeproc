Feature: nameattr
  As a CSL cite processor hacker
  I want the test nameattr_NamesDelimiterOnCitationInCitation to pass

  @citation @nameattr
  Scenario: Names Delimiter On Citation In Citation
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
      <citation
          names-delimiter=" AND ALSO THE EDITOR ">
        <layout>
          <names variable="author editor">
            <name />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"}],"editor":[{"family":"Roe","given":"Jane"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John Doe AND ALSO THE EDITOR Jane Roe
    """
