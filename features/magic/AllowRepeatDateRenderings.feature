Feature: magic
  As a CSL cite processor hacker
  I want the test magic_AllowRepeatDateRenderings to pass

  @citation @magic @citation-items
  Scenario: Allow Repeat Date Renderings
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
        <layout delimiter="; ">
          <group prefix="(" suffix=").">
            <date variable="issued">
              <date-part name="year" />
            </date>
            <choose>
              <if match="none" type="book chapter article-journal">
                <date variable="issued">
                  <date-part name="month" prefix=", " />
                  <date-part name="day" prefix=" " />
                </date>
              </if>
            </choose>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","issued":{"date-parts":[[2006,1,20]]},"type":"book"},{"id":"ITEM-2","issued":{"date-parts":[[2007,2,15]]},"type":"article-newspaper"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | (2006).              |
      | (2007, February 15). |
