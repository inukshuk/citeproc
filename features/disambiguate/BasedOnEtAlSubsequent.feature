Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_BasedOnEtAlSubsequent to pass

  @citation @disambiguate
  Scenario: Based On Et Al Subsequent
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
             disambiguate-add-year-suffix="true"
             et-al-min="3"
             et-al-subsequent-min="1"
             et-al-subsequent-use-first="1"
             et-al-use-first="3">
        <layout delimiter="; " prefix="(" suffix=")">
          <names variable="author">
            <name and="symbol" delimiter=", " delimiter-precedes-last="never" form="short" />
          </names>
          <date prefix=" " variable="issued">
            <date-part name="year" />
          </date>
          <text font-style="italic" variable="year-suffix" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Baur","given":"Bruno","static-ordering":false},{"family":"Fröberg","given":"Lars","static-ordering":false},{"family":"Baur","given":"Anette","static-ordering":false},{"family":"Guggenheim","given":"Richard","static-ordering":false},{"family":"Haase","given":"Martin","static-ordering":false}],"container-title":"Nordic Journal of Botany","id":"ITEM-1","issued":{"date-parts":[["2000"]]},"page":"119-128","title":"Ultrastructure of snail grazing damage to calcicolous lichens","type":"article-journal","volume":"20"},{"author":[{"family":"Baur","given":"Bruno","static-ordering":false},{"family":"Schileyko","given":"Anatoly A.","static-ordering":false},{"family":"Baur","given":"Anette","static-ordering":false}],"container-title":"Journal of Molluscan Studies","id":"ITEM-2","issued":{"date-parts":[["2000"]]},"page":"285-289","title":"Ecological observations on _Arianta aethiops aethiops_ (Helicidae), a land snail endemic to the South Carpathian mountains, Romania","type":"article-journal","volume":"66"},{"author":[{"family":"Doe","given":"John","static-ordering":false}],"container-title":"Journal of Irreproducible Results","id":"ITEM-3","issued":{"date-parts":[["2000"]]},"page":"5-7","title":"Some bogus title","type":"article-journal","volume":"666"}]
    """
    When I cite all items
    Then the result should be:
    """
    (Baur, Fröberg, Baur, et al. 2000<i>a</i>; Baur, Schileyko &amp; Baur 2000<i>b</i>; Doe 2000)
    """
