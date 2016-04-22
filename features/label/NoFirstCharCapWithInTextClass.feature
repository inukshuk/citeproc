Feature: label
  As a CSL cite processor hacker
  I want the test label_NoFirstCharCapWithInTextClass to pass

  @citation @label
  Scenario: No First Char Cap With In Text Class
    Given the following style:
    """
    <style 
          xmlns="http://purl.org/net/xbiblio/csl"
          class="in-text"
          version="1.0">
      <info>
        <id />
        <title />
        <updated>2009-08-10T04:49:00+09:00</updated>
      </info>
      <locale>
        <terms>
          <term name="no date">n.d.</term>
        </terms>
      </locale>
      <citation>
        <layout>
          <text term="no date"/>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"title":"His Anonymous Life","type":"book"}]
    """
    When I cite all items
    Then the result should be:
    """
    n.d.
    """
