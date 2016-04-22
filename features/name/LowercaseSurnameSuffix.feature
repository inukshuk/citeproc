Feature: name
  As a CSL cite processor hacker
  I want the test name_LowercaseSurnameSuffix to pass

  @citation @name
  Scenario: Lowercase Surname Suffix
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
            <name initialize-with=""/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Chen","given":"Guo-ping"}],"id":"ITEM-1","type":"article-journal"}]
    """
    When I cite all items
    Then the result should be:
    """
    G Chen
    """
