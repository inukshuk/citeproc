Feature: sort
  As a CSL cite processor hacker
  I want the test sort_TestInheritance to pass

  @citation @sort @citation-items
  Scenario: Test Inheritance
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
          <name/>
        </names>
      </macro>
      <citation name-form="short">
        <sort>
          <key macro="author" />
        </sort>
        <layout delimiter="; ">
          <text macro="author" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Bottom","given":"Brad"}],"id":"ITEM-2","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"},{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | Aalto; Bottom |
