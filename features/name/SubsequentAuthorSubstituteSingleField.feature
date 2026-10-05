Feature: name
  As a CSL cite processor hacker
  I want the test name_SubsequentAuthorSubstituteSingleField to pass

  @bibliography @name @citation-items
  Scenario: Subsequent Author Substitute Single Field
    Given the following style:
    """
    <?xml version="1.0" encoding="utf-8"?>
    <style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0" demote-non-dropping-particle="display-and-sort" page-range-format="chicago">
      <info>
        <title>Chicago Manual of Style 17th edition (author-date)</title>
        <id>http://www.zotero.org/styles/chicago-author-date</id>
        <link href="http://www.zotero.org/styles/chicago-author-date" rel="self"/>
        <link href="http://www.chicagomanualofstyle.org/tools_citationguide.html" rel="documentation"/>
        <author>
          <name>Julian Onions</name>
          <email>julian.onions@gmail.com</email>
        </author>
        <category citation-format="author-date"/>
        <category field="generic-base"/>
        <summary>The author-date variant of the Chicago style</summary>
        <updated>2018-01-24T12:00:00+00:00</updated>
        <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
      </info>
      <locale xml:lang="en">
        <terms>
          <term name="editor" form="verb-short">ed.</term>
          <term name="container-author" form="verb">by</term>
          <term name="translator" form="verb-short">trans.</term>
          <term name="editortranslator" form="verb">edited and translated by</term>
          <term name="translator" form="short">trans.</term>
        </terms>
      </locale>
      <macro name="contributors">
        <group delimiter=". ">
          <names variable="author">
            <name and="text" name-as-sort-order="first" sort-separator=", " delimiter=", " delimiter-precedes-last="always"/>
            <label form="short" prefix=", "/>
            <substitute>
              <text variable="container-title"/>
            </substitute>
          </names>
        </group>
      </macro>
      <citation et-al-min="4" et-al-use-first="1" disambiguate-add-year-suffix="true" disambiguate-add-names="true" disambiguate-add-givenname="true" givenname-disambiguation-rule="primary-name" collapse="year" after-collapse-delimiter="; ">
        <layout prefix="(" suffix=")" delimiter="; ">
          <text macro="contributors"/>
        </layout>
      </citation>
      <bibliography subsequent-author-substitute="&#8212;&#8212;&#8212;">
        <layout suffix=".">
          <group delimiter=". ">
            <text macro="contributors"/>
          </group>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"container-title":"Yomiuri Shinbun","id":"ITEM-1","title":"Ashita no tenki","type":"article-newspaper"},{"container-title":"Yomiuri Shinbun","id":"ITEM-2","title":"Asatte no tenki","type":"article-newspaper"}]
    """
    When I render the entire bibliography
    Then the bibliography should be:
    """
    <div class="csl-bib-body">
      <div class="csl-entry">Yomiuri Shinbun.</div>
      <div class="csl-entry">———.</div>
    </div>
    """
