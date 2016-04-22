Feature: sort
  As a CSL cite processor hacker
  I want the test sort_AuthorDateWithYearSuffix to pass

  @citation @sort @citations
  Scenario: Author Date With Year Suffix
    Given the following style:
    """
    <?xml version="1.0" encoding="utf-8"?>
    <style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0" demote-non-dropping-particle="sort-only">
      <info>
        <title>The Journal of Neuroscience (Author-Date)</title>
        <id>http://www.zotero.org/styles/journal-neuroscience</id>
        <link href="http://www.zotero.org/styles/journal-neuroscience" rel="self"/>
        <author>
          <name>Ullrich Bartsch</name>
          <email>ubartsch@gmail.com</email>
        </author>
        <category citation-format="author-date"/>
        <category field="medicine"/>
        <updated>2008-01-04T12:25:13+00:00</updated>
        <summary>The Journal of Neuroscience style</summary>
        <link href="http://www.jneurosci.org/misc/ifa_organization.shtml" rel="documentation"/>
        <!-- modified from Harvard1 style by Julian Onions-->
        <rights>This work is licensed under a Creative Commons Attribution-Share Alike 3.0 License: http://creativecommons.org/licenses/by-sa/3.0/</rights>
      </info>
      <!-- Problems:
           author disambiguation if not in the same citation!-->
      <macro name="editor">
        <names variable="editor" delimiter=", ">
          <name and="symbol" initialize-with=". " delimiter=", "/>
          <label form="short" prefix=", " text-case="lowercase" suffix="." strip-periods="true"/>
        </names>
      </macro>
      <macro name="anon">
        <text term="anonymous" form="short" text-case="capitalize-first" strip-periods="true"/>
      </macro>
      <macro name="author-bib">
        <names variable="author">
          <name name-as-sort-order="all" sort-separator=" " initialize-with="" delimiter=", " delimiter-precedes-last="always"/>
          <label form="short" prefix=" " suffix="." text-case="lowercase" strip-periods="true"/>
          <substitute>
    	<names variable="editor"/>
    	<text macro="anon"/>
          </substitute>
        </names>
      </macro>
      <macro name="author-cit">
        <names variable="author">
          <name form="short" and="text" delimiter=" " initialize-with=""/>
          <substitute>
    	<names variable="editor"/>
    	<names variable="translator"/>
    	<text macro="anon"/>
          </substitute>
        </names>
      </macro>
      <macro name="access">
        <choose>
          <if variable="URL">
    	<text value="Available at:" suffix=" "/>
    	<text variable="URL"/>
    	<group prefix=" [" suffix="]">
    	  <text term="accessed" text-case="capitalize-first" suffix=" "/>
    	  <date variable="accessed">
    	    <date-part name="month" suffix=" "/>
    	    <date-part name="day" suffix=", "/>
    	    <date-part name="year"/>
    	  </date>
    	</group>
          </if>
        </choose>
      </macro>
      <macro name="title">
        <choose>
          <if type="bill book graphic legal_case motion_picture report song" match="any">
    	<text variable="title"/>
          </if>
          <else>
    	<text variable="title"/>
          </else>
        </choose>
      </macro>
      <macro name="publisher">
        <group delimiter=": ">
          <text variable="publisher-place"/>
          <text variable="publisher"/>
        </group>
      </macro>
      <macro name="year-date">
        <choose>
          <if variable="issued">
    	<date variable="issued">
    	  <date-part name="year"/>
    	</date>
          </if>
          <else>
    	<text term="no date" form="short"/>
          </else>
        </choose>
      </macro>
      <macro name="year-sort">
        <choose>
          <if variable="issued">
    	<date variable="issued">
    	  <date-part name="year"/>
    	</date>
          </if>
        </choose>
      </macro>
      <macro name="edition">
        <choose>
          <if is-numeric="edition">
    	<group delimiter=" ">
    	  <number variable="edition" form="ordinal"/>
    	  <text term="edition" form="short" suffix="." strip-periods="true"/>
    	</group>
          </if>
          <else>
    	<text variable="edition" suffix="."/>
          </else>
        </choose>
      </macro>
      <!--   formatting citation      -->
      <citation et-al-min="3" et-al-use-first="1" disambiguate-add-year-suffix="true" collapse="year">
        <sort>
          <key variable="issued"/>
        </sort>
        <layout prefix="(" suffix=")" delimiter="; ">
          <group delimiter=" ">
    	<group delimiter=", ">
    	  <text macro="author-cit"/>
    	  <text macro="year-date"/>
    	</group>
    	<text variable="locator" prefix="p."/>
          </group>
        </layout>
      </citation>
      <!--  formatting bibliography  -->
      <bibliography hanging-indent="true" et-al-min="20" et-al-use-first="1">
        <sort>
          <key macro="author-bib"/>
          <key macro="year-date"/>
        </sort>
        <layout suffix=".">
          <group delimiter=" ">
    	<text macro="author-bib"/>
    	<text macro="year-date" prefix="(" suffix=")"/>  
          </group>     
          <choose>
    	<if type="bill book graphic legal_case motion_picture report song" match="any">
    	  <group prefix=" " delimiter=" " suffix=".">
    	    <text macro="title"/>
    	    <text macro="edition"/>
    	    <text macro="editor"/>
    	  </group>
    	  <text prefix=" " suffix="." macro="publisher"/>
    	</if>
    	<else-if type="chapter paper-conference" match="any">
    	  <text macro="title" prefix=" "/>
    	  <group prefix=" ">
    	    <text term="in" text-case="capitalize-first"/>
    	    <text macro="editor" prefix=" "/>
    	    <text variable="container-title" font-style="normal" prefix=" " suffix=" "/>
    	    <text variable="collection-title" prefix=" " suffix="."/>
    	    <group suffix=".">
    	      <text macro="publisher" prefix=" "/>
    	      <group prefix=", ">
    		<text variable="page" prefix="p. "/>
    	      </group>
    	    </group>
    	  </group>
    	</else-if>
    	<else>
    	  <group suffix="." delimiter=" " prefix=" ">
    	    <text macro="title"/>
    	    <text macro="editor"/>
    	  </group>
    	  <group prefix=" ">
    	    <text variable="container-title" font-style="normal" form="short" strip-periods="true"/>
    	    <text variable="volume" prefix=" "/>
    	    <group prefix=":">
    	      <text variable="page" prefix=""/>
    	    </group>
    	  </group>
    	</else>
          </choose>
          <text prefix=" " macro="access" suffix=""/>
        </layout>
      </bibliography>
    </style>
    """
    And the following input:
    """
    [{"author":[{"family":"Day","given":"B. L.","isInstitution":""},{"family":"Fitzpatrick","given":"R. C.","isInstitution":""}],"container-title":"Curr Biol","id":30,"issue":"15","issued":{"date-parts":[[2005]]},"multi":{"_keys":{}},"page":"R583-6","title":"The vestibular system","type":"article-journal","volume":"15"},{"author":[{"family":"Mian","given":"O.S.","isInstitution":""},{"family":"Thom","given":"J. M.","isInstitution":""},{"family":"Narici","given":"M. V.","isInstitution":""},{"family":"Baltzopoulos","given":"V.","isInstitution":""}],"event":"European College of Sport Science 10th Annual Congress","event-place":"Belgrade, Serbia","id":32,"issued":{"date-parts":[[2005]]},"multi":{"_keys":{}},"page":"129-130","publisher-place":"Belgrade, Serbia","title":"Stair descent: kinematics in healthy young and older adults","type":"paper-conference"},{"abstract":"The vestibular organs can feed perceptual processes that build a picture of our route as we move about in the world. However, raw vestibular signals do not define the path taken because, during travel, the head can undergo accelerations unrelated to the route and also be orientated in any direction to vary the signal. This study investigated the computational process by which the brain transforms raw vestibular signals for the purpose of route reconstruction. We electrically stimulated the vestibular nerves of human subjects to evoke a virtual head rotation fixed in skull co-ordinates and measure its perceptual effect. The virtual head rotation caused subjects to perceive an illusory whole-body rotation that was a cyclic function of head-pitch angle. They perceived whole-body yaw rotation in one direction with the head pitched forwards, the opposite direction with the head pitched backwards, and no rotation with the head in an intermediate position. A model based on vector operations and the anatomy and firing properties of semicircular canals precisely predicted these perceptions. In effect, a neural process computes the vector dot product between the craniocentric vestibular vector of head rotation and the gravitational unit vector. This computation yields the signal of body rotation in the horizontal plane that feeds our perception of the route travelled.","author":[{"family":"Day","given":"B. L.","isInstitution":""},{"family":"Fitzpatrick","given":"R. C.","isInstitution":""}],"container-title":"J Physiol","id":29,"issue":"Pt 2","issued":{"date-parts":[[2005]]},"multi":{"_keys":{}},"page":"591-7","title":"Virtual head rotation reveals a process of route reconstruction from human vestibular signals","type":"article-journal","volume":"567"}]
    """
    And I have a citations input
    When I cite all items
    Then the result should be:
    """
    >>[0] (Day and Fitzpatrick, 2005a, 2005b; Mian et al., 2005)
    """
