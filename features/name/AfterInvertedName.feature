Feature: name
  As a CSL cite processor hacker
  I want the test name_AfterInvertedName to pass

  @citation @name @citations
  Scenario: After Inverted Name
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
      <citation et-al-min="3" et-al-use-first="1" disambiguate-add-names="true">
        <layout delimiter="; ">
          <names variable="author">
            <name name-as-sort-order="first"
                  delimiter-precedes-et-al="after-inverted-name"
                  delimiter-precedes-last="after-inverted-name"
                  and="text">
              <name-part name="family" text-case="uppercase"/>
            </name>
          </names>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Doebuck","given":"Jonathan"},{"family":"Roe","given":"Jane"},{"family":"Snoakes","given":"Richard"}],"id":"ITEM-1","type":"book"},{"author":[{"family":"Doe","given":"John"},{"family":"Roe","given":"Jane"},{"family":"Snoakes","given":"Richard"},{"family":"Noakes","given":"Robert"}],"id":"ITEM-2","type":"book"},{"author":[{"family":"Doe","given":"John"},{"family":"Roebuck","given":"Janice"},{"family":"Snoakes","given":"Richard"},{"family":"Noakes","given":"Robert"}],"id":"ITEM-3","type":"book"},{"author":[{"family":"Appleby","given":"Aloysius"},{"family":"Brown","given":"Bobby"}],"id":"ITEM-4","type":"book"},{"author":[{"family":"Appleby","given":"Aloysius"},{"family":"Brown","given":"Bobby"},{"family":"Cream","given":"Cecile"}],"id":"ITEM-5","type":"book"},{"author":[{"family":"Appleby","given":"Aloysius"},{"family":"Brown","given":"Bobby"},{"family":"Evergreen","given":"Enola"}],"id":"ITEM-6","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    ..[0] DOEBUCK, Jonathan, et al.; DOE, John, Jane ROE et al.; DOE, John, Janice ROEBUCK et al.
    >>[1] APPLEBY, Aloysius, and Bobby BROWN; APPLEBY, Aloysius, Bobby BROWN and Cecile CREAM; APPLEBY, Aloysius, Bobby BROWN and Enola EVERGREEN
    """
