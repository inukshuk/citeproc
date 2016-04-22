Feature: display
  As a CSL cite processor hacker
  I want the test display_AuthorAsHeading to pass

  @bibliography @display
  Scenario: Author As Heading
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
        <layout>
          <names variable="author">
            <name />
          </names>
          <date variable="issued">
            <date-part name="year" />
          </date>
        </layout>
      </citation>
      <bibliography 
             subsequent-author-substitute="">
        <layout>
          <group display="block">
            <names variable="author">
              <name and="text" />
            </names>
          </group>
          <group display="left-margin">
            <date variable="issued">
              <date-part name="year" />
            </date>
            <text variable="year-suffix" />
          </group>
          <group display="right-inline">
            <text variable="title" />
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John Aloysius","static-ordering":false}],"id":"ITEM-1","issued":{"date-parts":[[1999]]},"title":"Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa","type":"book"},{"author":[{"family":"Doe","given":"John Aloysius","static-ordering":false}],"id":"ITEM-2","issued":{"date-parts":[[2000]]},"title":"Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb","type":"book"},{"author":[{"family":"Roe","given":"Jane Henrietta","static-ordering":false}],"id":"ITEM-3","issued":{"date-parts":[[1999]]},"title":"Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc","type":"book"},{"author":[{"family":"Roe","given":"Jane Henrietta","static-ordering":false}],"id":"ITEM-4","issued":{"date-parts":[[1999]]},"title":"Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd","type":"book"},{"author":[{"family":"Roe","given":"Jane Henrietta","static-ordering":false}],"id":"ITEM-5","issued":{"date-parts":[[2000]]},"title":"Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">
    
        <div class="csl-block">John Aloysius Doe</div>
    
        <div class="csl-left-margin">1999</div><div class="csl-right-inline">Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa Aaaaa</div>
      </div>
      <div class="csl-entry">
        <div class="csl-left-margin">2000</div><div class="csl-right-inline">Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb Bbbbb</div>
      </div>
      <div class="csl-entry">
    
        <div class="csl-block">Jane Henrietta Roe</div>
    
        <div class="csl-left-margin">1999a</div><div class="csl-right-inline">Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc Ccccc</div>
      </div>
      <div class="csl-entry">
        <div class="csl-left-margin">1999b</div><div class="csl-right-inline">Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd Ddddd</div>
      </div>
      <div class="csl-entry">
        <div class="csl-left-margin">2000</div><div class="csl-right-inline">Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee Eeeee</div>
      </div>
    </div>
    """
