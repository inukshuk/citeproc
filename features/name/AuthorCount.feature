Feature: name
  As a CSL cite processor hacker
  I want the test name_AuthorCount to pass

  @citation @name
  Scenario: Author Count
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
        <layout delimiter=" | ">
          <text value="Count=("/>
          <names variable="author">
            <name form="count" />
          </names>
          <text value=")"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Roe","given":"Jane","static-ordering":false},{"family":"Brown","given":"Robert","static-ordering":false},{"family":"Smith","given":"Tom","static-ordering":false}],"id":"item-1","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Doe","given":"Jake","static-ordering":false},{"family":"Brown","given":"Robert","static-ordering":false}],"id":"item-2","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false},{"family":"Doe","given":"Jake","static-ordering":false}],"id":"item-3","type":"book"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"id":"item-4","type":"book"},{"editor":[{"family":"Doe","given":"John","static-ordering":false}],"id":"item-5","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Count=(3) | Count=(3) | Count=(2) | Count=(1) | Count=()
    """
