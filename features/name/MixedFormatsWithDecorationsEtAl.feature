Feature: name
  As a CSL cite processor hacker
  I want the test name_MixedFormatsWithDecorationsEtAl to pass

  @citation @name
  Scenario: Mixed Formats With Decorations Et Al
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
             et-al-min="6"
             et-al-use-first="5">
        <layout delimiter="; ">
          <names variable="author">
            <name delimiter=", ">
              <name-part name="family" text-case="uppercase" />
            </name>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Чайковский","given":"Пётр Ильич","static-ordering":false},{"family":"Winkle","given":"Rip","non-dropping-particle":"van","static-ordering":false},{"family":"我妻","given":"栄","static-ordering":false},{"family":"Thucydides","given":"Carl","static-ordering":false,"suffix":"III"},{"family":"Tokugawa","given":"Ieyasu","static-ordering":true},{"given":"Prince","static-ordering":false}],"id":"item-1","issued":{"date-parts":[["2000"]]},"title":"Our Story","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Пётр Ильич ЧАЙКОВСКИЙ, Rip VAN WINKLE, 我妻栄, Carl THUCYDIDES III, TOKUGAWA Ieyasu, et al.
    """
