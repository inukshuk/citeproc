Feature: magic
  As a CSL cite processor hacker
  I want the test magic_PunctuationInQuoteFalseSuppressExtra to pass

  @citation @magic
  Scenario: Punctuation In Quote False Suppress Extra
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
        <style-options punctuation-in-quote="false" />
      </locale>
      <citation>
        <layout>
          <text quotes="true" variable="title" />
          <text variable="container-title" prefix=". "/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"Journal B","id":"ITEM-1","title":"Article A?","type":"article-journal"}]
    """
    When I cite all items
    Then the result should be:
    """
    “Article A?” Journal B
    """
