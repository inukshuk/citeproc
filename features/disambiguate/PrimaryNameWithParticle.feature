Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_PrimaryNameWithParticle to pass

  @citation @disambiguate
  Scenario: Primary Name With Particle
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          demote-non-dropping-particle="never"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <citation
             disambiguate-add-givenname="true"
             givenname-disambiguation-rule="primary-name">
        <layout delimiter="; ">
          <names delimiter=", " variable="author">
            <name and="text" delimiter-precedes-last="never" name-as-sort-order="first" initialize-with="." form="short"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"dos Smith","given":"Alan"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Smith","given":"Beatrice"}],"id":"ITEM-2","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    dos Smith; Smith
    """
