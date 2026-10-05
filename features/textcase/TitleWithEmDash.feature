Feature: textcase
  As a CSL cite processor hacker
  I want the test textcase_TitleWithEmDash to pass

  @citation @textcase @citation-items
  Scenario: Title With Em Dash
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
        <layout delimiter="; ">
          <text variable="title" text-case="title"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"id":"ITEM-1","title":"Relationship of core self-evaluation traits—self-esteem, generalized self-efficacy, locus of control, and emotional stability—with job satisfaction and job performance: a meta-analysis","type":"book"}]
    """
    When I cite the following items:
    """
    [[{"id":"ITEM-1"}]]
    """
    Then the results should be:
      | Relationship of Core Self-Evaluation Traits—Self-Esteem, Generalized Self-Efficacy, Locus of Control, and Emotional Stability—with Job Satisfaction and Job Performance: A Meta-Analysis |
