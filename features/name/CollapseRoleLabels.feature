Feature: name
  As a CSL cite processor hacker
  I want the test name_CollapseRoleLabels to pass

  @citation @name
  Scenario: Collapse Role Labels
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
      <locale xml:lang="en">
        <terms>
          <term form="short" name="editortranslator">
            <single>ed. &#38; trans.</single>
            <multiple>eds. &#38; trans.</multiple>
          </term>
        </terms>
      </locale>
      <citation 
             et-al-min="3"
             et-al-use-first="1">
        <layout delimiter="; ">
          <names delimiter=", " variable="editor translator">
            <name delimiter=", " />
            <label form="short" prefix=" (" suffix=")" />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"editor":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false}],"id":"editor-translator-1","issued":{"date-parts":[["1990"]]},"title":"Book One","translator":[{"family":"Asthma","given":"Albert","static-ordering":false},{"family":"Bronchitis","given":"Bosworth","static-ordering":false},{"family":"Cold","given":"Crispin","static-ordering":false}],"type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Albert Asthma et al. (eds. &amp; trans.)
    """
