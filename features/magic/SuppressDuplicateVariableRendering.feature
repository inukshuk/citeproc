Feature: magic
  As a CSL cite processor hacker
  I want the test magic_SuppressDuplicateVariableRendering to pass

  @citation @magic
  Scenario: Suppress Duplicate Variable Rendering
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
          <text prefix="Should print this: " variable="title" />
          <text prefix=" &#8230; and this: " variable="title" />
          <names variable="author" prefix=" &#8230; but this only once: ">
            <name/>
            <substitute>
              <names variable="editor"/>
            </substitute>
          </names>
          <names variable="editor">
            <name/>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"editor":[{"literal":"Blob"}],"id":"item-1","title":"Book A","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    Should print this: Book A … and this: Book A … but this only once: Blob
    """
