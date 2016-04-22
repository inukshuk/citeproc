Feature: decorations
  As a CSL cite processor hacker
  I want the test decorations_SimpleFlipFlop to pass

  @citation @decorations
  Scenario: Simple Flip Flop
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
          <text font-style="italic" variable="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"item-1","title":"My <i>Amazing</i> Title","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    <i>My <span style="font-style:normal;">Amazing</span> Title</i>
    """
