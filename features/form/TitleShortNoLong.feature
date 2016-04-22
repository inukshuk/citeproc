Feature: form
  As a CSL cite processor hacker
  I want the test form_TitleShortNoLong to pass

  @citation @form
  Scenario: Title Short No Long
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
          <text variable="title" form="short"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","shortTitle":"Book A","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Book A
    """
