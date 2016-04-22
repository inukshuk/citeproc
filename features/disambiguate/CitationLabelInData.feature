Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_CitationLabelInData to pass

  @citation @disambiguate
  Scenario: Citation Label In Data
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
             disambiguate-add-year-suffix="true">
        <layout delimiter="; ">
            <text variable="citation-label"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Asthma","given":"Albert","static-ordering":false}],"citation-label":"SpiffLabel1900","id":"ITEM-1","issued":{"date-parts":[["1900"]]},"title":"Book A","type":"book"},{"author":[{"family":"Asthma","given":"Zeppo","static-ordering":false}],"citation-label":"SpiffLabel1900","id":"ITEM-2","issued":{"date-parts":[["2000"]]},"title":"Book B","type":"book"},{"author":[{"family":"Bronchitis","given":"Buffy"}],"id":"ITEM-3","issued":{"date-parts":[["2000"]]},"title":"Book C","type":"book"},{"author":[{"family":"Bronchitis","given":"Buffy"},{"family":"Cholera","given":"Cleopatra"}],"id":"ITEM-4","issued":{"date-parts":[["1998"]]},"title":"Book D","type":"book"},{"author":[{"family":"von Dipheria","given":"Doug"},{"family":"Eczema","given":"Elihugh"},{"family":"Flatulence","given":"Frankie"},{"family":"Goiter","given":"Gus"},{"family":"Hiccups","given":"Harvey"}],"id":"ITEM-5","issued":{"date-parts":[["1926"]]},"title":"Book D","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    SpiffLabel1900a; SpiffLabel1900b; Bron00; BrCh98; DEFG26
    """
