Feature: integration
  As a CSL cite processor hacker
  I want the test integration_DuplicateItem2 to pass

  @citation @integration @citations
  Scenario: Duplicate Item2
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
             disambiguate-add-names="true"
             disambiguate-add-givenname="true">
        <layout delimiter="; ">
          <group delimiter=" ">
            <names delimiter=", " variable="author">
              <name and="symbol" delimiter-precedes-last="never" form="short"/>
            </names>
            <date variable="issued" prefix="(" suffix=")">
              <date-part name="year"/>
            </date>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"la Berge","given":"S. P"},{"family":"Nagel","given":"L. E"},{"family":"Dement","given":"W. C"},{"family":"Zarcone","given":"V. P"}],"call-number":"0049","container-title":"Perceptual and motor skills","id":1772,"issue":"3","issued":{"date-parts":[[1981]]},"page":"727–732","title":"Lucid dreaming verified by volitional communication during REM sleep.","type":"article-journal","volume":"52"},{"author":[{"family":"la Berge","given":"S. P"},{"family":"Nagel","given":"L. E"},{"family":"Dement","given":"W. C"},{"family":"Zarcone","given":"V. P"}],"call-number":"0049","container-title":"Perceptual and motor skills","id":1773,"issue":"3","issued":{"date-parts":[[1981]]},"page":"727–732","title":"Lucid dreaming verified by volitional communication during REM sleep.","type":"article-journal","volume":"52"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] la Berge, Nagel, Dement &amp; Zarcone (1981)
    """
