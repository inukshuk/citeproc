Feature: variables
  As a CSL cite processor hacker
  I want the test variables_ShortForm to pass

  @citation @variables @citation-items
  Scenario: Short Form
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
          <choose>
            <if type="article-journal">
              <choose>
                <if variable="title">
                  <text form="long" variable="container-title" />
                </if>
                <else>
                  <text form="short" variable="container-title" />
                </else>
              </choose>
            </if>
            <else>
              <text variable="container-title" />
            </else>
          </choose>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"container-title":"The Compleat and Utter History of the World","id":"ITEM-1","type":"book"},{"container-title":"Journal of Irreproducible Results","id":"ITEM-2","type":"article-journal"},{"container-title":"Journal of Irreproducible Results","id":"ITEM-3","title":"Sublimation Rates of Subatomic Particles","type":"article-journal"}]
    """
    And the following abbreviations:
    """
    {"default":{"container-title":{"Journal of Irreproducible Results":"J. Irrep. Res."}}}
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}],[{"id":"ITEM-3"}],[{"id":"ITEM-2"}]]
    """
    Then the results should be:
      | The Compleat and Utter History of the World  |
      | Journal of Irreproducible Results            |
      | J. Irrep. Res.                               |
