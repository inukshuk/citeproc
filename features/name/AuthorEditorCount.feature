Feature: name
  As a CSL cite processor hacker
  I want the test name_AuthorEditorCount to pass

  @citation @name
  Scenario: Author Editor Count
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
             et-al-min="4"
             et-al-use-first="3">
        <layout>
          <names variable="author editor">
            <name form="count" />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Brown","given":"Robert","static-ordering":false},{"family":"Smith","given":"Tom","static-ordering":false}],"editor":[{"family":"Bloggs","given":"Joe","static-ordering":false},{"family":"Bloggs","given":"Barbie","static-ordering":false}],"id":"item-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    5
    """
