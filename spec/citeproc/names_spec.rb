# -*- coding: utf-8 -*-

require 'spec_helper'

module CiteProc

  describe 'CiteProc Names' do

    let(:poe) { Name.new(:family => 'Poe', :given => 'Edgar Allen') }
    let(:joe) { Name.new(:given => 'Joe') }
    let(:plato) { Name.new(:given => 'Plato') }
    let(:aristotle) { Name.new(:given => 'Ἀριστοτέλης') }
    let(:dostoyevksy) { Name.new(:given => 'Фёдор Михайлович', :family => 'Достоевский') }
    let(:saer_decomposed) { Name.new(:family => 'Saer', :given => 'Juan José') }
    let(:saer_precomposed) { Name.new(:family => 'Saer', :given => 'Juan José') }

    let(:utf) { Name.new(
      :given => 'Gérard',
      :'dropping-particle' => 'de',
      :'non-dropping-particle' => 'la',
      :family => 'Martinière',
      :suffix => 'III')
    }

    let(:markup) { Name.new(
      :given => '<b>Gérard</b>',
      :'dropping-particle' => 'd<i>e</i>',
      :'non-dropping-particle' => 'la',
      :family => 'Mar<strong>tinière</strong>',
      :suffix => 'III')
    }


    let(:japanese) { Name.new(
      "family" => "穂積",
      "given" => "陳重")
    }

    let(:saunders) { Name.new("family" => "Saunders", "given" => "John Bertrand de Cusance Morant") }

    let(:humboldt) { Name.new(
      "family" => "Humboldt",
      "given" => "Alexander",
      "dropping-particle" => "von")
    }

    let(:van_gogh) { Name.new(
      "family" => "Gogh",
      "given" => "Vincent",
      "non-dropping-particle" => "van")
    }

    let(:jr) { Name.new(
      "family" => "Stephens",
      "given" => "James",
      "suffix" => "Jr.")
    }

    let(:frank) { Name.new(
      "family" => "Bennett",
      "given" => "Frank G.",
      "suffix" => "Jr.",
      "comma-suffix" => "true")
    }

    let(:ramses) { Name.new(
      :family => 'Ramses',
      :given => 'Horatio',
      :suffix => 'III')
    }

    describe Name do


      it { is_expected.not_to be_nil }

      describe 'string-like behaviour' do
        let(:name) { Name.new(:family => 'Doe', :given => 'John') }

        it 'converts implicitly to strings' do
          expect('By ' + name).to eq('By John Doe')
          expect(/Doe/ === name).to be true
        end

        it 'supports string matching' do
          expect(name =~ /Doe/).to eq(5)
          expect(name).to match(/John/)
          expect(name.start_with?('John')).to be true
          expect(name.include?('Doe')).to be true
        end

        it 'supports some string transformations' do
          expect(name.upcase).to eq('JOHN DOE')
          expect(name.gsub('o', '0')).to eq('J0hn D0e')
          expect(name.split).to eq(%w{ John Doe })
        end

        it 'does not support other string methods' do
          expect(name).not_to respond_to(:clear)
          expect(name).not_to respond_to(:encoding)
        end

        it 'returns the number of attributes as its length' do
          expect(name.length).to eq(2)
        end

        it 'compares names by their attributes' do
          expect([name, Name.new(:family => 'Doe', :given => 'John')].uniq.length).to eq(1)
          expect(name).not_to eql(Name.new(:family => 'Roe', :given => 'Jane'))
        end

        it 'can be frozen' do
          expect(name.freeze).to equal(name)
          expect(name).to be_frozen
        end
      end

      describe 'formatting options' do

        it 'always demotes particle by default' do
          expect(Name.new.always_demote_particle?).to be true
          expect(Name.new.always_demote_non_dropping_particle?).to be true
        end

        it 'demotes particle by default' do
          expect(Name.new.demote_particle?).to be true
          expect(Name.new.demote_non_dropping_particle?).to be true
        end

        it 'does not demote particle if option is set to never' do
          expect(Name.new({}, :'demote-non-dropping-particle' => 'never').sort_order!.demote_particle?).to be false
        end

        it 'always demotes particle if option is set' do
          expect(Name.new({}, :'demote-non-dropping-particle' => 'display-and-sort').always_demote_particle?).to be true
          expect(Name.new({}, :'demote-non-dropping-particle' => 'display-and-sort').always_demote_non_dropping_particle?).to be true
        end

        it 'demotes particle in sort order if option is set to display-and-sort' do
          expect(Name.new({}, :'demote-non-dropping-particle' => 'display-and-sort').sort_order!.demote_particle?).to be true
        end

        it 'does not demote particle in sort order if option is set to sort-only' do
          expect(Name.new({}, :'demote-non-dropping-particle' => 'sort-only').sort_order!.demote_particle?).to be false
        end

        it 'is not set to never demote particle by default' do
          expect(Name.new.never_demote_particle?).to be false
          expect(Name.new.never_demote_non_dropping_particle?).to be false
        end

        it 'is not in sort order by default' do
          expect(Name.new.sort_order?).to be false
        end

        it 'uses the long form by default' do
          expect(Name.new).to be_long_form
        end

        it 'does not use short form by default' do
          expect(Name.new).not_to be_short_form
        end

      end

      describe '#initials' do
        let(:name) { Name.new({ family: 'Doe' }, :'initialize-with' => '. ') }

        it 'returns the given name initials' do
          name.given = 'Edgar A'
          expect(name.initials).to eq('E. A.')

          name.options[:initialize] = 'false'
          expect(name.initials).to eq('Edgar A.')
        end

        it 'initializes words and keeps existing initials' do
          {
            'James T.' => 'J. T.',
            'James T' => 'J. T.',
            'JT' => 'J.',
            'M.E' => 'M. E.',
            'ME.' => 'ME.',
            'Ph.M.E.' => 'Ph. M. E.',
            'Jean-Luc' => 'J.-L.',
            'Vérité Äpfel' => 'V. Ä.',
            'TSerendorjiin' => 'Ts.',
            'Guo-ping' => 'G.'
          }.each do |given, initials|
            name.given = given
            expect(name.initials).to eq(initials)
          end
        end

        it 'initializes only existing initials if initialize is false' do
          name.options[:initialize] = 'false'
          {
            'James T. Kirk' => 'James T. Kirk',
            'James T.Kirk' => 'James T. Kirk',
            'James T' => 'James T.',
            'JT' => 'JT',
            'Jean-Luc' => 'Jean-Luc',
            'J.-L.M.' => 'J.-L. M.',
            'J-L' => 'J.-L.',
            'Ph. M.E.' => 'Ph. M. E.',
            'Guo-ping' => 'Guo-ping'
          }.each do |given, initials|
            name.given = given
            expect(name.initials).to eq(initials)
          end
        end

        it 'accepts xsd:boolean values for initialize' do
          name.given = 'James T.'

          name.options[:initialize] = '0'
          expect(name.initials).to eq('James T.')

          name.options[:initialize] = '1'
          expect(name.initials).to eq('J. T.')
        end

        it 'joins the initials using the initialize-with string' do
          name.options[:'initialize-with'] = '.'
          {
            'James T.' => 'J.T.',
            'Jean-Luc' => 'J.-L.',
            'Ph.M.E.' => 'Ph.M.E.',
            'John Bertrand de Cusance Morant' => 'J.B. de C.M.'
          }.each do |given, initials|
            name.given = given
            expect(name.initials).to eq(initials)
          end

          name.options[:'initialize-with'] = ''
          name.given = 'John M.E.'
          expect(name.initials).to eq('JME')
          name.options[:initialize] = 'false'
          expect(name.initials).to eq('John ME')
        end

        it 'does not initialize names without a family name' do
          name.family = nil
          name.given = 'Banksy'
          expect(name.initials).to eq('Banksy')
        end

        it 'drops hyphens if initialize-with-hyphen is false' do
          name.initialize_without_hyphen!
          name.given = 'Jean-Luc'
          expect(name.initials).to eq('J. L.')

          name.options[:'initialize-with'] = '.'
          expect(name.initials).to eq('J.L.')
        end
      end

      describe 'constructing' do

        describe '.new' do

          it 'accepts a symbolized hash' do
            expect(Name.new(:family => 'Doe').format).to eq('Doe')
          end

          it 'accepts a stringified hash' do
            expect(Name.new('family' => 'Doe').format).to eq('Doe')
          end

        end

      end

      describe '#parse_particles!' do
        def parse(attributes)
          Name.new(attributes).parse_particles!.to_citeproc
        end

        it 'parses leading lowercase words of the family name as non-dropping particles' do
          expect(parse(family: 'van Gogh', given: 'Vincent')).to eq(
            'family' => 'Gogh', 'given' => 'Vincent', 'non-dropping-particle' => 'van')
          expect(parse(family: 'van der Vlist', given: 'Eric')).to eq(
            'family' => 'Vlist', 'given' => 'Eric', 'non-dropping-particle' => 'van der')
          expect(parse(family: "d'Aubignac", given: 'François')).to eq(
            'family' => 'Aubignac', 'given' => 'François', 'non-dropping-particle' => "d'")
          expect(parse(family: 'al-One', given: 'Alan')).to eq(
            'family' => 'One', 'given' => 'Alan', 'non-dropping-particle' => 'al-')
          expect(parse(family: "'t Hart", given: 'Jan')).to eq(
            'family' => 'Hart', 'given' => 'Jan', 'non-dropping-particle' => "'t")
        end

        it 'parses trailing lowercase words of the given name as dropping particles' do
          expect(parse(family: 'Humboldt', given: 'Alexander von')).to eq(
            'family' => 'Humboldt', 'given' => 'Alexander', 'dropping-particle' => 'von')
          expect(parse(family: 'Familyname', given: 'Givenname von der')).to eq(
            'family' => 'Familyname', 'given' => 'Givenname', 'dropping-particle' => 'von der')
          expect(parse(family: 'Aubignac', given: "François Hédelin d'")).to eq(
            'family' => 'Aubignac', 'given' => 'François Hédelin', 'dropping-particle' => "d'")
        end

        it 'keeps capitalized words' do
          expect(parse(family: 'Di Familyname', given: 'Givenname')).to eq(
            'family' => 'Di Familyname', 'given' => 'Givenname')
          expect(parse(family: "L'Familyname", given: 'Givenname')).to eq(
            'family' => "L'Familyname", 'given' => 'Givenname')
        end

        it 'does not parse names without given name or with explicit particles' do
          expect(parse(family: 'van Gogh')).to eq('family' => 'van Gogh')
          expect(parse(family: 'van Gogh', given: 'Vincent', 'non-dropping-particle': 'de')).to eq(
            'family' => 'van Gogh', 'given' => 'Vincent', 'non-dropping-particle' => 'de')
        end

        it 'does not parse names if parse-names is false' do
          expect(parse(family: 'van Gogh', given: 'Vincent', 'parse-names': false)).to include(
            'family' => 'van Gogh', 'given' => 'Vincent')
          expect(parse(family: 'van Gogh', given: 'Vincent', 'parse-names': 'false')).to include(
            'family' => 'van Gogh', 'given' => 'Vincent')
        end

        it 'does not parse quoted family names but removes the quotes' do
          expect(parse(family: '"van Gogh"', given: 'Vincent')).to eq(
            'family' => 'van Gogh', 'given' => 'Vincent')
        end
      end

      describe '#dup' do

        it 'returns a new name copied by value' do
          expect(poe.dup.upcase!.format).not_to eq(poe.format)
        end

      end

      describe 'script awareness' do

        it 'english names are romanesque' do
          expect(frank).to be_romanesque
        end

        it 'ancient greek names are romanesque' do
          expect(aristotle).to be_romanesque
        end

        it 'russian names are romanesque' do
          expect(dostoyevksy).to be_romanesque
        end

        it 'japanese names are not romanesque' do
          expect(japanese).not_to be_romanesque
        end

        it 'german names are romanesque' do
          expect(Name.new(:given => 'Friedrich', :family => 'Hölderlin')).to be_romanesque
        end

        it 'french names are romanesque' do
          expect(utf).to be_romanesque
        end

        it 'markup does not interfere with romanesque test' do
          expect(markup).to be_romanesque
        end

      end

      describe '#invertible?' do
        it 'is true for personal names in romanesque scripts' do
          expect(poe).to be_invertible
        end

        it 'is false for literal names and names in static order' do
          expect(Name.new(:literal => 'GNU/Linux')).not_to be_invertible
          expect(japanese).not_to be_invertible
        end
      end

      describe 'literals' do

        it 'is a literal if the literal attribute is set' do
          expect(Name.new(:literal => 'GNU/Linux')).to be_literal
        end

        it 'is not literal by default' do
          expect(Name.new).not_to be_literal
        end

        it 'is literal even if other name parts are set' do
          expect(Name.new(:family => 'Tux', :literal => 'GNU/Linux')).to be_literal
        end

      end

      describe 'in-place manipulation (bang! methods)' do

        it 'delegates to string for family name' do
          expect(plato.downcase!.format).to eq('plato')
        end

        it 'delegates to string for given name' do
          expect(humboldt.gsub!(/^Alex\w*/, 'Wilhelm').format).to eq('Wilhelm von Humboldt')
        end

        it 'delegates to string for dropping particle' do
          expect(humboldt.upcase!.dropping_particle).to eq('VON')
        end

        it 'delegates to string for non dropping particle' do
          expect(van_gogh.upcase!.non_dropping_particle).to eq('VAN')
        end

        it 'delegates to string for suffix' do
          expect(frank.sub!(/jr./i, 'Sr.').format).to eq('Frank G. Bennett, Sr.')
        end

        it 'returns the name object' do
          expect(poe.upcase!).to be_a(Name)
        end

        it 'does not support other bang methods' do
          expect(poe).not_to respond_to(:succ!)
          expect(poe).not_to respond_to(:reverse!)
        end

      end


      describe '#format' do

        it 'returns an empty string by default' do
          expect(Name.new.format).to be_empty
        end

        it 'returns the last name if only last name is set' do
          expect(Name.new(:family => 'Doe').format).to eq('Doe')
        end

        it 'returns the first name if only the first name is set' do
          expect(Name.new(:given => 'John').format).to eq('John')
        end

        it 'prints japanese names using static ordering' do
          expect(japanese.format).to eq('穂積陳重')
        end

        it 'returns the literal if the name is a literal' do
          Name.new(:literal => 'GNU/Linux').format == 'GNU/Linux'
        end

        it 'returns the name in display order by default' do
          expect(Name.new(:family => 'Doe', :given => 'John').format).to eq('John Doe')
        end

        it 'returns the name in sort order if the sort order option is active' do
          expect(Name.new(:family => 'Doe', :given => 'John').sort_order!.format).to eq('Doe, John')
        end

        describe 'with name-part formatting' do
          let(:name) do
            Name.new(:given => 'Jean', :'dropping-particle' => 'de',
              :'non-dropping-particle' => 'La', :family => 'Fontaine', :suffix => 'III')
          end

          let(:formatter) { ->(part, text) { part == :family ? text.upcase : text } }
          let(:affixer) { ->(part, text) { part == :family ? "(#{text})" : "[#{text}]" } }

          it 'formats the parts and encloses particles and suffix in the family affixes' do
            expect(name.format(formatter, affixer)).to eq('[Jean] (de LA FONTAINE III)')
          end

          it 'encloses particles in the affixes of the parts they follow in sort order' do
            expect(name.sort_order!.format(formatter, affixer)).to eq('(FONTAINE), [Jean de LA], III')
            expect(name.never_demote_particle!.format(formatter, affixer)).to eq('(LA FONTAINE), [Jean de], III')
          end

          it 'formats the family name and non-dropping particle in short form' do
            expect(name.short_form!.format(formatter, affixer)).to eq('(LA FONTAINE)')
          end

          it 'formats literal names like family names' do
            expect(Name.new(:literal => 'Banksy').format(formatter, affixer)).to eq('(BANKSY)')
          end
        end

        it 'joins particles ending in a hyphen or apostrophe without a space' do
          name = Name.new(:family => 'One', :given => 'Alan', :'non-dropping-particle' => 'al-')
          expect(name.format).to eq('Alan al-One')
          expect(name.sort_order!.never_demote_particle!.format).to eq('al-One, Alan')
          expect(name.short_form!.format).to eq('al-One')

          name = Name.new(:family => 'Aubignac', :'non-dropping-particle' => "d'")
          expect(name.format).to eq("d'Aubignac")

          name = Name.new(:family => 'Aubignac', :given => 'François', :'dropping-particle' => "d'")
          expect(name.format).to eq("François d'Aubignac")
        end

        it 'returns the full given name' do
          expect(saunders.format).to eq('John Bertrand de Cusance Morant Saunders')
        end

        it 'includes dropping particles' do
          expect(humboldt.format).to eq('Alexander von Humboldt')
        end

        it 'includes non dropping particles' do
          expect(van_gogh.format).to eq('Vincent van Gogh')
        end

        it 'includes suffices' do
          expect(jr.format).to eq('James Stephens Jr.')
        end

        it 'uses the comma suffix option' do
          expect(frank.format).to eq('Frank G. Bennett, Jr.')
        end

        it 'prints unicode characters' do
          expect(utf.format).to eq("Gérard de la Martinière III")
        end

        it 'prints russian names normally' do
          expect(dostoyevksy.format).to eq('Фёдор Михайлович Достоевский')
        end

        describe 'when static ordering is active' do

          it 'always prints the family name first' do
            expect(poe.static_order!.format).to eq('Poe Edgar Allen')
          end

        end

        describe 'when the sort order option is active' do

          it 'returns an empty string by default' do
            expect(Name.new.sort_order!.format).to be_empty
          end

          it 'returns the last name if only last name is set' do
            expect(Name.new({:family => 'Doe'}, { :'name-as-sort-order' => true }).format).to eq('Doe')
          end

          it 'returns the first name if only the first name is set' do
            expect(Name.new(:given => 'John').sort_order!.format).to eq('John')
          end

          it 'prints japanese names using static ordering' do
            expect(japanese.sort_order!.format).to eq('穂積陳重')
          end

          it 'returns the literal if the name is a literal' do
            Name.new(:literal => 'GNU/Linux').sort_order!.format == 'GNU/Linux'
          end

          it 'uses comma for suffix if comma suffix is set' do
            expect(frank.sort_order!.format).to eq('Bennett, Frank G., Jr.')
          end

          it 'also uses comma for suffix if comma suffix is *not* set' do
            expect(jr.sort_order!.format).to eq('Stephens, James, Jr.')
          end

          it 'for normal names it prints them as "family, given"' do
            expect(poe.sort_order!.format).to eq('Poe, Edgar Allen')
          end

          context 'with accents at the end of the name' do
            it 'prints with precomposed accent as "family, given"' do
              expect(!saer_precomposed.short_form?).to be true
              expect(!saer_precomposed.romanesque?).to be false
              expect(saer_precomposed.static_order?).to be false
              expect(saer_precomposed.sort_order!.format).to eq('Saer, Juan José')
            end

            it 'prints with decomposed accent as "family, given"' do
              expect(!saer_decomposed.short_form?).to be true
              expect(!saer_decomposed.romanesque?).to be false
              expect(saer_decomposed.static_order?).to be false
              expect(saer_decomposed.sort_order!.format).to eq('Saer, Juan José')
            end
          end

          it 'particles come after given name by default' do
            expect(van_gogh.sort_order!.format).to eq('Gogh, Vincent van')
          end

          it 'particles come before the family name if never demoted' do
            expect(van_gogh.sort_order!.never_demote_particle!.format).to eq('van Gogh, Vincent')
          end

          it 'particles come after given name if demote option is active' do
            expect(van_gogh.sort_order!.demote_particle!.format).to eq('Gogh, Vincent van')
          end

          it 'dropping particles come after given name' do
            expect(humboldt.sort_order!.format).to eq('Humboldt, Alexander von')
          end

          it 'by default if all parts are set they are returned as "family, first dropping-particle particle, suffix"' do
            expect(utf.sort_order!.format).to eq('Martinière, Gérard de la, III')
          end

        end

      end

      describe '#to_s' do
        it 'returns the formatted name' do
          expect(poe.to_s).to eq('Edgar Allen Poe')
          expect(utf.to_s).to eq('Gérard de la Martinière III')
        end

        it 'returns the literal for literal names' do
          expect(Name.new(:literal => 'GNU/Linux').to_s).to eq('GNU/Linux')
        end

        it 'respects the formatting options' do
          expect(utf.sort_order!.to_s).to eq('Martinière, Gérard de la, III')
        end
      end

      describe '#empty?' do
        it 'is true for names without any parts' do
          expect(Name.new).to be_empty
        end

        it 'is false for names with a given or family name' do
          expect(joe).not_to be_empty
          expect(Name.new(:family => 'Poe')).not_to be_empty
        end

        it 'is false for literal names' do
          expect(Name.new(:literal => 'GNU/Linux')).not_to be_empty
        end
      end

      describe '#sort_order' do

        it 'returns only a single token for literal names' do
          expect(Name.new(:literal => 'ACME Corp.').sort_order.size).to eq(1)
        end

        it 'strips leading "the" off literal names' do
          expect(Name.new(:literal => 'The ACME Corp.').sort_order[0]).to eq('ACME Corp.')
        end

        it 'strips leading "a" off literal names' do
          expect(Name.new(:literal => 'A Company').sort_order[0]).to eq('Company')
        end

        it 'strips leading "an" off literal names' do
          expect(Name.new(:literal => 'an ACME Corp.').sort_order[0]).to eq('ACME Corp.')
        end

        it 'strips leading "l\'" off literal names' do
          expect(Name.new(:literal => "L'Augustine").sort_order[0]).to eq('Augustine')
        end

        it 'always returns four tokens for non literal names' do
          expect(poe.sort_order.size).to eq(4)
          expect(joe.sort_order.size).to eq(4)
          expect(aristotle.sort_order.size).to eq(4)
          expect(utf.sort_order.size).to eq(4)
          expect(frank.sort_order.size).to eq(4)
          expect(japanese.sort_order.size).to eq(4)
        end

        it 'demotes non dropping particles if option is set' do
          expect(van_gogh.demote_particle!.sort_order).to eq(['Gogh', 'van', 'Vincent', ''])
        end

        it 'demotes non dropping particles by default' do
          expect(van_gogh.sort_order).to eq(['Gogh', 'van', 'Vincent', ''])
        end

        it 'demotes dropping and non dropping particles by default' do
          expect(utf.sort_order).to eq(['Martinière', 'de la', 'Gérard', 'III'])
        end

        it 'demotes dropping particles' do
          expect(humboldt.sort_order).to eq(['Humboldt', 'von', 'Alexander', ''])
        end

        it 'combines non dropping particles with family name if option demote-non-dropping-particles is not active' do
          expect(van_gogh.never_demote_particle!.sort_order).to eq(['van Gogh', '', 'Vincent', ''])
        end

      end

      describe 'sorting' do

        it 'sorts by sort order by default' do
          expect([poe, utf, joe, plato].sort).to eq([joe, plato, utf, poe])
        end

      end


    end

    describe Names do

      let(:gang_of_four) {
        Names.parse!('Erich Gamma and Richard Helm and Ralph Johnson and John Vlissides')
      }

      it { is_expected.not_to be nil }
      it { is_expected.not_to be_numeric }

      describe 'constructing' do

        it 'accepts a single name' do
          expect { Names.new(joe) }.not_to raise_error
        end

        it 'accepts a single name as hash' do
          expect(Names.new(:given => 'Jim').names.size).to eq(1)
        end

        it 'accepts two names' do
          expect(Names.new(joe, poe).names.size).to eq(2)
        end

        it 'accepts two names as hash' do
          expect(Names.new({:given => 'Jim'}, {:family => 'Jameson'}).names.size).to eq(2)
        end

        it 'parses particles of names given as hash' do
          expect(Names.new(:family => 'van Gogh', :given => 'Vincent').first.particle).to eq('van')
        end

        it 'accepts an array of names' do
          expect(Names.new([joe, poe]).names.size).to eq(2)
        end

      end

      describe 'parsing' do
        it 'accepts a single name as a string' do
          expect(Names.parse('Edgar A. Poe').names.size).to eq(1)
        end

        it 'accepts multiple names as a string' do
          expect(Names.parse('Edgar A. Poe and Hawthorne, Nathaniel and Herman Melville').names.size).to eq(3)
        end

        it 'parses the passed-in family names' do
          expect(Names.parse('Edgar A. Poe and Hawthorne, Nathaniel and Herman Melville').map { |n|
            n.values_at(:family) }.flatten).to eq(%w{ Poe Hawthorne Melville })
        end

        it '#parse returns nil on error' do
          expect(Names.parse(23)).to be_nil
        end

        it '#parse! raises an error on bad input' do
          expect { Names.parse!('23') }.to raise_error(ParseError)
        end

      end

      describe '#strip_markup' do

        it 'strips markup off string representation' do
          expect(Names.new(markup).strip_markup).to eq(utf.to_s)
        end

        it 'when using the bang! version, strips markup off each name part' do
          expect(Names.new(markup).strip_markup![0]).to eq(utf)
        end


      end

      describe 'bang! methods' do
        it 'delegate to the individual names and return self' do
          expect(Names.new(poe, plato, joe).upcase!.map(&:given)).to eq(['EDGAR ALLEN', 'PLATO', 'JOE'])
        end
      end

      [:never, :always, :contextually].each do |setting|
        setter = "delimiter_#{setting}_precedes_last!"
        predicate = "delimiter_#{setting}_precedes_last?"

        describe "##{setter}" do
          it 'sets the delimiter precedes last option accordingly' do
            expect(Names.new.send(setter).send(predicate)).to eq(true)
          end
        end
      end

      describe '#delimiter_precedes_last' do
        it 'returns false by default' do
          expect(Names.new(joe)).not_to be_delimiter_precedes_last
        end

        it 'returns false by default for a single name' do
          expect(Names.new(joe)).not_to be_delimiter_precedes_last
        end

        it 'returns false by default for two names' do
          expect(Names.new(joe, poe)).not_to be_delimiter_precedes_last
        end

        it 'returns true for two names when option set to always' do
          expect(Names.new(joe, poe).delimiter_always_precedes_last!).to be_delimiter_precedes_last
        end

        it 'returns true by default for three names' do
          expect(Names.new(joe, poe, plato)).to be_delimiter_precedes_last
        end

        it 'returns false for three names when option set to :never' do
          expect(Names.new(joe, poe, plato).delimiter_never_precedes_last!).not_to be_delimiter_precedes_last
        end
      end

      describe '#to_bibtex' do

        describe 'when there is only a single name' do
          it 'prints the name in sort order' do
            expect(Names.new(poe).to_bibtex).to eq('Poe, Edgar Allen')
          end
        end

        describe 'when there are two or more names' do
          it 'prints the names in sort order connected with the word "and"' do
            expect(Names.new(poe, plato, humboldt).to_bibtex).to eq('Poe, Edgar Allen and Plato and Humboldt, Alexander von')
          end
        end

      end

      describe '#to_s' do

        describe 'when the number of names exceeds the et-al-min option' do
          before do
            gang_of_four.options[:'et-al-min'] = 3
            gang_of_four.options[:'et-al-use-first'] = 2
            gang_of_four.options[:'et-al'] = 'FOO'
          end

          it 'prints only the et-al-use-first names' do
            expect(gang_of_four.to_s).to match(/gamma.+helm/i)
            expect(gang_of_four.to_s).not_to match(/johnson|vlissides/i)
          end

          it 'adds et-al at the end' do
            expect(gang_of_four.to_s).to end_with('FOO')
          end

          it 'adds the delimiter before et-al when multiple names are printed' do
            expect(gang_of_four.to_s).to end_with(', FOO')
          end

          it 'does not add the delimiter before et-al when only one name is printed' do
            gang_of_four.options[:'et-al-use-first'] = 1
            expect(gang_of_four.to_s).not_to end_with(', FOO')
          end

        end

        it 'squeezes multiple whitespace between delimiter and connector' do
          expect(Names.new(poe, humboldt, van_gogh, joe).to_s).not_to match(/\s{2}/)
        end
      end

      describe '#each' do
        it 'returns an enumerator when no block given' do
          expect(gang_of_four.each).to respond_to(:each)
        end
      end

      describe '#to_citeproc' do
        it 'returns a list of hashes' do
          expect(gang_of_four.to_citeproc.map(&:class).uniq).to eq([Hash])
        end
      end

      describe 'sorting' do
        it 'accepts other Names instance' do
          expect(Names.new(poe, plato) <=> Names.new(plato)).to equal(1)
          expect(Names.new(plato) <=> Names.new(poe, plato)).to equal(-1)
        end

        it 'accepts other list of names' do
          expect(Names.new(poe, plato) <=> [plato]).to equal(1)
          expect(Names.new(plato) <=> [poe, plato]).to equal(-1)
        end
      end

      describe '#inspect' do
        it 'returns a string' do
          expect(gang_of_four.inspect).to be_a(String)
        end
      end

    end

  end

end
