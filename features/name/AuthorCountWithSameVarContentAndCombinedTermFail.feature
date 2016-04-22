Feature: name
  As a CSL cite processor hacker
  I want the test name_AuthorCountWithSameVarContentAndCombinedTermFail to pass

  @citation @name
  Scenario: Author Count With Same Var Content And Combined Term Fail
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
        <terms>
          <term form="short" name="editortranslator">
            <single>ed. &#38; trans.</single>
            <multiple>eds. &#38; trans.</multiple>
          </term>
        </terms>
      </locale>
      <citation 
             et-al-min="4"
             et-al-use-first="3">
        <layout>
          <names variable="author editor">
            <name form="count" />
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Noakes","given":"John"},{"family":"Stoakes","given":"Richard"}],"editor":[{"family":"Noakes","given":"John"},{"family":"Stoakes","given":"Richard"}],"id":"item-1","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    4
    """
