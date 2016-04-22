Feature: label
  As a CSL cite processor hacker
  I want the test label_PluralNumberOfVolumes to pass

  @citation @label
  Scenario: Plural Number Of Volumes
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
        <layout delimiter="; ">
          <group delimiter=" ">
            <label variable="number-of-volumes"/>
            <text variable="number-of-volumes" text-case="title"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","number-of-volumes":1,"type":"book"},{"id":"ITEM-2","number-of-volumes":2,"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    volume 1; volumes 2
    """
