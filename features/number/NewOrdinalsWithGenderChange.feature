Feature: number
  As a CSL cite processor hacker
  I want the test number_NewOrdinalsWithGenderChange to pass

  @citation @number
  Scenario: New Ordinals With Gender Change
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="note"
          version="1.0"
          default-locale="fr-FR">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <locale locale="fr-FR">
        <terms>
          <!-- ORDINALS -->
         <term name="ordinal">EE</term>
         <term name="ordinal-01" gender-form="feminine" match="whole-number">ʳᵉfemmie</term>
         <term name="ordinal-01" gender-form="masculine" match="whole-number">ᵉʳmacho</term>
        </terms>
      </locale>
      <citation>
        <layout delimiter="; ">
          <group delimiter=": ">
            <text variable="title"/>
            <number variable="edition" form="ordinal"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"edition":1,"id":"ITEM-1","title":"Title 1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Title 1: 1<sup>r</sup><sup>e</sup>femmie
    """
