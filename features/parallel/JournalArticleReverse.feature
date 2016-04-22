Feature: parallel
  As a CSL cite processor hacker
  I want the test parallel_JournalArticleReverse to pass

  @citation @parallel @citation-items
  Scenario: Journal Article Reverse
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
      <citation year-suffix-delimiter=", ">
        <layout delimiter="; ">
          <choose>
            <if position="first">
              <group delimiter=", ">
                <text variable="title"/>
                <group delimiter=" ">
                  <text variable="volume"/>
                  <text variable="container-title"/>
                  <text variable="page"/>
                  <date variable="issued" date-parts="year" form="text" prefix="(" suffix=")"/>
                </group>
              </group>
            </if>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"U.S.","id":"ITEM-1","issued":{"date-parts":[["1965"]]},"page":"200","title":"Smith v. Noakes","type":"legal_case","volume":"222"},{"container-title":"L.Ed.","id":"ITEM-2","issued":{"date-parts":[["1965"]]},"page":"300","title":"Smith v. Noakes","type":"legal_case","volume":"333"},{"container-title":"U.S.","id":"ITEM-3","issued":{"date-parts":[["1965"]]},"page":"400","title":"Jim v. Bob","type":"legal_case","volume":"444"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"},{"id":"ITEM-2"},{"id":"ITEM-3"}]]
    """
    Then the results should be:
      | Smith v. Noakes, 222 U.S. 200, 333 L.Ed. 300 (1965); Jim v. Bob, 444 U.S. 400 (1965) |
