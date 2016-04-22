Feature: name
  As a CSL cite processor hacker
  I want the test name_MultipleLiteral to pass

  @citation @name
  Scenario: Multiple Literal
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
          <names variable="author">
            <name initialize-with="" delimiter="; "/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John J."},{"family":"Jones","given":"Gregory"},{"family":"Smith","given":"Bob"},{"family":"Alfred Benzon Foundation","isInstitution":"true"},{"family":"James Benson Foundation","isInstitution":"true"},{"family":"John Candy Foundation","isInstitution":"true"}],"id":"ITEM-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    JJ Doe; G Jones; B Smith; Alfred Benzon Foundation; James Benson Foundation; John Candy Foundation
    """
