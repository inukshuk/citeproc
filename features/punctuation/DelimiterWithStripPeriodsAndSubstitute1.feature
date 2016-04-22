Feature: punctuation
  As a CSL cite processor hacker
  I want the test punctuation_DelimiterWithStripPeriodsAndSubstitute1 to pass

  @bibliography @punctuation
  Scenario: Delimiter With Strip Periods And Substitute1
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
      <macro name="creator-macro">
        <names variable="author">
          <name and="text" delimiter-precedes-last="never" initialize-with=""/>
          <label form="short" prefix=" "/>
          <substitute>
            <names variable="editor"/>
          </substitute>
        </names>
      </macro>
      <citation>
        <layout>
          <text value="bogus"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <group delimiter=". ">
            <text macro="creator-macro" strip-periods="true"/>
            <text variable="title"/>
            <text variable="URL"/>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"URL":"http://example.com/","editor":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"},{"family":"Noakes","given":"Richard"}],"id":45,"title":"Book Title","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">J Doe, J Roe and R Noakes eds. Book Title. http://example.com/</div>
    </div>
    """
