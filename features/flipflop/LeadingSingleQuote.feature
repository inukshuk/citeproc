Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_LeadingSingleQuote to pass

  @citation @flipflop
  Scenario: Leading Single Quote
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
         <text variable="title" quotes="true"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"‘Parmenides’ 132c–133a and the development of Plato's thought","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    “‘Parmenides’ 132c–133a and the development of Plato’s thought”
    """
