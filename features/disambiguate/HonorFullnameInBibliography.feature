Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_HonorFullnameInBibliography to pass

  @bibliography @disambiguate @citations
  Scenario: Honor Fullname In Bibliography
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
      <citation disambiguate-add-givenname="true">
        <layout delimiter="; ">
    	  <names variable="author">
    		<name form="short" initialize-with="."/>
    	  </names>
        </layout>
      </citation>
      <bibliography>
        <sort>
          <key variable="author" />
        </sort>
        <layout>
    	  <names variable="author">
    		<name/>
    	  </names>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Aalto","given":"Alan"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Blevins","given":"Old"}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Aalto","given":"Richard"}],"id":"ITEM-3","type":"book"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Alan Aalto</div>
      <div class="csl-entry">Richard Aalto</div>
      <div class="csl-entry">Old Blevins</div>
    </div>
    """
