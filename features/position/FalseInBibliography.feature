Feature: position
  As a CSL cite processor hacker
  I want the test position_FalseInBibliography to pass

  @bibliography @position
  Scenario: False In Bibliography
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
          <text variable="title"/>
        </layout>
      </citation>
      <bibliography>
        <layout>
          <choose>
            <if position="first ibid ibid-with-locator" match="none">
              <text variable="title"/>
            </if>
            <else>
              <text value="I am weak, and I have failed."/>
            </else>
          </choose>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"His Anonymous Life","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">His Anonymous Life</div>
    </div>
    """
