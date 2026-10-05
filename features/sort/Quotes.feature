Feature: sort
  As a CSL cite processor hacker
  I want the test sort_Quotes to pass

  @bibliography @sort @citation-items
  Scenario: Quotes
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
      <macro name="title">
        <choose>
          <if type="article-journal">
            <text variable="title" quotes="true"/>
          </if>
          <else>
            <text variable="title"/>
          </else>
        </choose>
      </macro>
      <citation>
        <layout delimiter="; ">
          <text macro="title"/>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key macro="title"/>
        </sort>
        <layout>
          <text macro="title"/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Simple 'title' here C","type":"book"},{"id":"ITEM-2","title":"Simple title, here A","type":"book"},{"id":"ITEM-3","title":"Simple title here B","type":"article-journal"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Simple title, here A</div>
      <div class="csl-entry">“Simple title here B”</div>
      <div class="csl-entry">Simple “title” here C</div>
    </div>
    """
