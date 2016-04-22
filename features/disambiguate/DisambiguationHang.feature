Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_DisambiguationHang to pass

  @citation @disambiguate @citations
  Scenario: Disambiguation Hang
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
            et-al-use-first="1"
      		et-al-subsequent-min="3" 
    		et-al-subsequent-use-first="1" 
    		disambiguate-add-names="true" 
    		disambiguate-add-givenname="true"
            disambiguate-add-year-suffix="true">
        <layout prefix="(" suffix=")" delimiter="; ">
          <group delimiter=" ">
            <names variable="author">
      		  <name form="short" and="symbol"/>
            </names>
            <date variable="issued" form="text" date-parts="year"/>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Caminiti","given":"R"},{"family":"Johnson","given":"P B"},{"family":"Burnod","given":"Y"},{"family":"Galli","given":"C"},{"family":"Ferraina","given":"S"}],"id":"ITEM-1","issued":{"date-parts":[[1990]]},"type":"article-journal"},{"author":[{"family":"Caminiti","given":"R"},{"family":"Johnson","given":"P B"},{"family":"Burnod","given":"Y"},{"family":"Galli","given":"C"},{"family":"Ferraina","given":"S"}],"id":"ITEM-2","issued":{"date-parts":[[1990]]},"type":"article-journal"},{"author":[{"family":"Caminiti","given":"R"},{"family":"Johnson","given":"P B"},{"family":"Urbano","given":"A"}],"id":"ITEM-3","issued":{"date-parts":[[1990,7]]},"type":"article-journal"},{"author":[{"family":"Caminiti","given":"R"},{"family":"Johnson","given":"P B"},{"family":"Urbano","given":"A"}],"id":"ITEM-4","issued":{"date-parts":[[1990,7]]},"type":"article-journal"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] (Caminiti, Johnson, Burnod, Galli, &amp; Ferraina 1990a)
    >>[1] (Caminiti, Johnson, Burnod, Galli, &amp; Ferraina 1990b)
    >>[2] (Caminiti, Johnson, &amp; Urbano 1990)
    """
