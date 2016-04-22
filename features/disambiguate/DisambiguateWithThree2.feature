Feature: disambiguate
  As a CSL cite processor hacker
  I want the test disambiguate_DisambiguateWithThree2 to pass

  @citation @disambiguate @citations
  Scenario: Disambiguate With Three2
    Given the following style:
    """
    <style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0">
      <info>
        <title>Modern Language Association</title>
        <id>http://www.zotero.org/styles/mla</id>
        <link href="http://www.zotero.org/styles/mla" rel="self"/>
        <author>
          <name>Ilouise S. Bradford</name>
          <email>isbradford@gmail.com</email>
        </author>
        <contributor>
          <name>Sarah Ficke</name>
          <email>sficke@email.unc.edu</email>
        </contributor>
        <contributor>
          <name>Sebastian Karcher</name>
          <email>karcher@u.northwestern.edu</email>
        </contributor>
        <contributor>
          <name>Christian Werthschulte</name>
          <email>Christian.Werthschulte@rub.de</email>
        </contributor>
        <contributor>
          <name>Simon Kornblith</name>
          <email>simon@simonster.com</email>
        </contributor>
        <contributor>
          <name>James Johnston</name>
          <email>thejamesjohnston@gmail.com</email>
        </contributor>
        <category field="generic-base"/>
        <category citation-format="author"/>
        <link href="http://owl.english.purdue.edu/owl/section/2/11/" rel="documentation"/>
        <updated>2011-05-28T18:16:02+00:00</updated>
        <summary>This style adheres to the MLA 7th edition handbook and contains modifications to these types of sources: e-mail, forum posts, interviews, manuscripts, maps, presentations, TV broadcasts, and web pages.</summary>
        <rights>This work is licensed under a Creative Commons Attribution-Share Alike 3.0 License:
        http://creativecommons.org/licenses/by-sa/3.0/</rights>
      </info>
      <macro name="author-short">
        <names variable="author">
          <name form="short" and="text" delimiter=", " initialize-with=". "/>
          <substitute>
            <names variable="editor"/>
            <names variable="translator"/>
            <text macro="title-short"/>
          </substitute>
        </names>
      </macro>
      <macro name="title-short">
        <choose>
          <if type="bill book graphic legal_case manuscript motion_picture report song" match="any">
            <text variable="title" form="short" font-style="italic"/>
          </if>
          <else>
            <text variable="title" form="short" quotes="true"/>
          </else>
        </choose>
      </macro>
      <citation disambiguate-add-names="true">
        <layout prefix="(" suffix=")" delimiter="; ">
          <group delimiter=", ">
            <text macro="author-short"/>
            <choose>
              <if disambiguate="true">
                <text macro="title-short"/>
              </if>
            </choose>
          </group>
        </layout>
      </citation>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Spivak","given":"Gayatri Chakravorty","isInstitution":""}],"event-place":"Cambridge, Mass.","id":55,"issued":{"date-parts":[[1999]]},"multi":{"_keys":{}},"note":"Gayatri Chakravorty Spivak. 25 cm.","publisher":"Harvard University Press","publisher-place":"Cambridge, Mass.","shortTitle":"A Critique","title":"A Critique of Postcolonial Reason: Toward a History of the Vanishing Present","type":"book"},{"author":[{"family":"Spivak","given":"Gayatri Chakravorty","isInstitution":""}],"container-title":"Cosmopolitics: Thinking and Feeling Beyond the Nation","editor":[{"family":"Cheah","given":"Pheng","isInstitution":""},{"family":"Robbins","given":"Bruce","isInstitution":""}],"event-place":"Minneapolis","id":53,"issued":{"date-parts":[[1998]]},"multi":{"_keys":{}},"page":"329 - 348","publisher":"University of Minnesota Press","publisher-place":"Minneapolis","shortTitle":"Cultural Talks","title":"Cultural Talks in the 'Hot Peace': Revisiting the Global Village","type":"chapter"},{"author":[{"family":"Spivak","given":"Gayatri Chakravorty","isInstitution":""}],"event-place":"New York","id":59,"issued":{"date-parts":[[2003]]},"multi":{"_keys":{}},"note":"Gayatri Chakravorty Spivak. Crossing borders â€• Collectivities â€• Planetarity.","publisher":"Columbia University Press","publisher-place":"New York","title":"Death of a Discipline","type":"book"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] (Spivak, <i>A Critique</i>)
    >>[1] (Spivak, “Cultural Talks”)
    >>[2] (Spivak, <i>Death of a Discipline</i>)
    """
