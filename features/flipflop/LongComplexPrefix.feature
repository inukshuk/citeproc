Feature: flipflop
  As a CSL cite processor hacker
  I want the test flipflop_LongComplexPrefix to pass

  @citation @flipflop @citation-items
  Scenario: Long Complex Prefix
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
      <macro name="author">
        <names variable="author">
          <name form="short" />
        </names>
      </macro>
      <citation>
        <layout delimiter="; ">
          <text variable="title" />
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Other Book Title","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1","prefix":"The French translation provided there runs, <i>Toi, qui cultives notre philosophie sous lhabit étranger—et peut-être pas si étranger que cela, puisque la chevelure des naziréens et la consécration de la tête, dont il a toujours tenu le fer à lécart, sont aussi comme une loi des sanctuaires, et que la blancheur et l’éclat des vêtements appartiennent aux anges, quand on les représente sous une forme corporelle: c’est, je pense, le symbole de la pureté propre à leur nature—!</i> "}]]
    """
    Then the results should be:
      | The French translation provided there runs, <i>Toi, qui cultives notre philosophie sous lhabit étranger—et peut-être pas si étranger que cela, puisque la chevelure des naziréens et la consécration de la tête, dont il a toujours tenu le fer à lécart, sont aussi comme une loi des sanctuaires, et que la blancheur et l’éclat des vêtements appartiennent aux anges, quand on les représente sous une forme corporelle: c’est, je pense, le symbole de la pureté propre à leur nature—!</i> Other Book Title |
