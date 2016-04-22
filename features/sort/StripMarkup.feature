Feature: sort
  As a CSL cite processor hacker
  I want the test sort_StripMarkup to pass

  @citation @sort
  Scenario: Strip Markup
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
        <sort>
          <key variable="title"/>
          <key variable="author"/>
        </sort>
        <layout delimiter=", ">
          <names variable="author">
            <name form="short"/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doe","given":"John"}],"id":"ITEM-1","title":"A Full Anonymous Life","type":"book"},{"author":[{"family":"Roe","given":"Jane"}],"id":"ITEM-2","title":"A Full <i>Anonymous</i> Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Doe, Roe
    """
