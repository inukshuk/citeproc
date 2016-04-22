Feature: name
  As a CSL cite processor hacker
  I want the test name_Delimiter to pass

  @citation @name
  Scenario: Delimiter
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
        <layout delimiter=" OR ">
          <names variable="author">
            <name delimiter="; ">
              <name-part name="family" />
            </name>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"}],"id":"item-1","type":"book"},{"author":[{"family":"Doe Inc.","given":"","isInstitution":true},{"family":"Doe Inc.","given":"","isInstitution":true},{"family":"Noakes Inc.","given":"","isInstitution":true}],"id":"item-2","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    John Doe; Jane Roe OR Doe Inc.; Doe Inc.; Noakes Inc.
    """
