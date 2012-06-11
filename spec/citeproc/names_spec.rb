# -*- coding: utf-8 -*-

require 'spec_helper'

module CiteProc
  
  describe 'CiteProc Names' do

    let(:poe) { Name.new(:family => 'Poe', :given => 'Edgar Allen') }
    let(:joe) { Name.new(:given => 'Joe') }
    let(:plato) { Name.new(:given => 'Plato') }
    let(:aristotle) { Name.new(:given => 'Ἀριστοτέλης') }
    let(:dostoyevksy) { Name.new(:given => 'Фёдор Михайлович', :family => 'Достоевский') }
    
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


      it { should_not be_nil }

      describe 'formatting options' do
      
        it 'does not always demote particle by default' do
          Name.new.always_demote_particle?.should be false
          Name.new.always_demote_non_dropping_particle?.should be false
        end

        it 'does not demote particle by default' do
          Name.new.demote_particle?.should be false
          Name.new.demote_non_dropping_particle?.should be false
        end

        it 'does not demote particle in sort order by default' do
          Name.new.sort_order!.demote_particle?.should be false
          Name.new.sort_order!.demote_non_dropping_particle?.should be false
        end

        it 'always demotes particle if option is set' do
          Name.new({}, :'demote-non-dropping-particle' => 'display-and-sort').always_demote_particle?.should be true
          Name.new({}, :'demote-non-dropping-particle' => 'display-and-sort').always_demote_non_dropping_particle?.should be true
        end

        it 'demotes particle in sort order if option is set to sort-only' do
          Name.new({}, :'demote-non-dropping-particle' => 'display-and-sort').sort_order!.demote_particle?.should be true
        end
      
        it 'never demotes particle by default' do
          Name.new.never_demote_particle?.should be true
          Name.new.never_demote_non_dropping_particle?.should be true
        end
      
        it 'is not in sort order by default' do
          Name.new.sort_order?.should be false
        end
      
        it 'uses the long form by default' do
          Name.new.should be_long_form
        end
      
        it 'does not use short form by default' do
          Name.new.should_not be_short_form
        end
      
      end

      describe 'constructing' do
      
        describe '.new' do
        
          it 'accepts a symbolized hash' do
            Name.new(:family => 'Doe').to_s.should == 'Doe'
          end

          it 'accepts a stringified hash' do
            Name.new('family' => 'Doe').to_s.should == 'Doe'
          end
        
        
        end
      
      end

      describe '#dup' do
        
        it 'returns a new name copied by value' do
          poe.dup.upcase!.to_s.should_not == poe.to_s
        end
        
      end
      
      describe 'script awareness' do
      
        it 'english names are romanesque' do
          frank.should be_romanesque
        end
      
        it 'ancient greek names are romanesque' do
          aristotle.should be_romanesque
        end
       
        it 'russian names are romanesque' do
          dostoyevksy.should be_romanesque
        end
      
        it 'japanese names are not romanesque' do
          japanese.should_not be_romanesque
        end
      
        it 'german names are romanesque' do
          Name.new(:given => 'Firedrich', :family => 'Hölderlin').should be_romanesque
        end
      
        it 'french names are romanesque' do
          utf.should be_romanesque
        end
      
        it 'markup does not interfere with romanesque test' do
          markup.should be_romanesque
        end
        
      end
    
      describe 'literals' do
      
        it 'is a literal if the literal attribute is set' do
          Name.new(:literal => 'GNU/Linux').should be_literal
        end
      
        it 'is not literal by default' do
          Name.new.should_not be_literal
        end
        
        it 'is literal even if other name parts are set' do
          Name.new(:family => 'Tux', :literal => 'GNU/Linux').should be_literal
        end
      
      end
    
      describe 'in-place manipulation (bang! methods)' do
      
        it 'delegates to string for family name' do
          plato.swapcase!.to_s.should == 'pLATO'
        end
      
        it 'delegates to string for given name' do
          humboldt.gsub!(/^Alex\w*/, 'Wilhelm').to_s.should == 'Wilhelm von Humboldt'
        end
      
        it 'delegates to string for dropping particle' do
          humboldt.upcase!.dropping_particle.should == 'VON'
        end
      
        it 'delegates to string for non dropping particle' do
          van_gogh.upcase!.non_dropping_particle.should == 'VAN'
        end
        
        it 'delegates to string for suffix' do
          frank.sub!(/jr./i, 'Sr.').to_s.should == 'Frank G. Bennett, Sr.'
        end
      
        it 'returns the name object' do
          poe.upcase!.should be_a(Name)
        end
      
      end
    
      
      describe '#to_s' do

        it 'returns an empty string by default' do
          Name.new.to_s.should be_empty
        end

        it 'returns the last name if only last name is set' do
          Name.new(:family => 'Doe').to_s.should == 'Doe'
        end

        it 'returns the first name if only the first name is set' do
          Name.new(:given => 'John').to_s.should == 'John'
        end

        it 'prints japanese names using static ordering' do
          japanese.to_s.should == '穂積 陳重'
        end

        it 'returns the literal if the name is a literal' do
          Name.new(:literal => 'GNU/Linux').to_s == 'GNU/Linux'
        end

        it 'returns the name in display order by default' do
          Name.new(:family => 'Doe', :given => 'John').to_s.should == 'John Doe'
        end

        it 'returns the name in sort order if the sort order option is active' do
          Name.new(:family => 'Doe', :given => 'John').sort_order!.to_s.should == 'Doe, John'
        end

        it 'returns the full given name' do
          saunders.to_s.should == 'John Bertrand de Cusance Morant Saunders'
        end

        it 'includes dropping particles' do
          humboldt.to_s.should == 'Alexander von Humboldt'
        end

        it 'includes non dropping particles' do
          van_gogh.to_s.should == 'Vincent van Gogh'
        end

        it 'includes suffices' do
          jr.to_s.should == 'James Stephens Jr.'
        end

        it 'uses the comma suffix option' do
          frank.to_s.should == 'Frank G. Bennett, Jr.'
        end

        it 'prints unicode characters' do
          utf.to_s.should == "Gérard de la Martinière III"
        end

        it 'prints russian names normally' do
          dostoyevksy.to_s.should == 'Фёдор Михайлович Достоевский'
        end

        describe 'when static ordering is active' do
        
          it 'always prints the family name first' do
            poe.static_order!.to_s.should == 'Poe Edgar Allen'
          end
        
        end
       
        describe 'when the sort order option is active' do

          it 'returns an empty string by default' do
            Name.new.sort_order!.to_s.should be_empty
          end

          it 'returns the last name if only last name is set' do
            Name.new({:family => 'Doe'}, { :'name-as-sort-order' => true }).to_s.should == 'Doe'
          end

          it 'returns the first name if only the first name is set' do
            Name.new(:given => 'John').sort_order!.to_s.should == 'John'
          end

          it 'prints japanese names using static ordering' do
            japanese.sort_order!.to_s.should == '穂積 陳重'
          end

          it 'returns the literal if the name is a literal' do
            Name.new(:literal => 'GNU/Linux').sort_order!.to_s == 'GNU/Linux'
          end

          it 'uses comma for suffix if comma suffix is set' do
            frank.sort_order!.to_s.should == 'Bennett, Frank G., Jr.'
          end
        
          it 'also uses comma for suffix if comma suffix is *not* set' do
            jr.sort_order!.to_s.should == 'Stephens, James, Jr.'
          end

          it 'for normal names it prints them as "family, given"' do
            poe.sort_order!.to_s.should == 'Poe, Edgar Allen'
          end
      
          it 'particles come after given name by default' do
            van_gogh.sort_order!.to_s.should == 'van Gogh, Vincent'
          end

          it 'particles come after given name if demote option is active' do
            van_gogh.sort_order!.demote_particle!.to_s.should == 'Gogh, Vincent van'
          end
        
          it 'dropping particles come after given name' do
            humboldt.sort_order!.to_s.should == 'Humboldt, Alexander von'
          end
        
          it 'by default if all parts are set they are returned as "particle family, first dropping-particle, suffix"' do
            utf.sort_order!.to_s.should == 'la Martinière, Gérard de, III'
          end
        
        end
      
      end
      
      describe '#sort_order' do
      
        it 'returns only a single token for literal names' do
          Name.new(:literal => 'ACME Corp.').sort_order.should have(1).element
        end
      
        it 'strips leading "the" off literal names' do
          Name.new(:literal => 'The ACME Corp.').sort_order[0].should == 'ACME Corp.'
        end
      
        it 'strips leading "a" off literal names' do
          Name.new(:literal => 'A Company').sort_order[0].should == 'Company'
        end

        it 'strips leading "an" off literal names' do
          Name.new(:literal => 'an ACME Corp.').sort_order[0].should == 'ACME Corp.'
        end
        
        it 'strips leading "l\'" off literal names' do
          Name.new(:literal => "L'Augustine").sort_order[0].should == 'Augustine'
        end
      
        it 'always returns four tokens for non literal names' do
          poe.sort_order.should have(4).elements
          joe.sort_order.should have(4).elements
          aristotle.sort_order.should have(4).elements
          utf.sort_order.should have(4).elements
          frank.sort_order.should have(4).elements
          japanese.sort_order.should have(4).elements
        end
      
        it 'demotes non dropping particles if option is set' do
          van_gogh.demote_particle!.sort_order.should == ['Gogh', 'van', 'Vincent', '']
        end

        it 'does not demote non dropping particles by default' do
          van_gogh.sort_order.should == ['van Gogh', '', 'Vincent', '']
        end

        it 'does not demote non dropping particles by default but dropping particles are demoted' do
          utf.sort_order.should == ['la Martinière', 'de', 'Gérard', 'III']
        end

        it 'demotes dropping particles' do
          humboldt.sort_order.should == ['Humboldt', 'von', 'Alexander', '']
        end
      
        it 'combines non dropping particles with family name if option demote-non-dropping-particles is not active' do
          van_gogh.never_demote_particle!.sort_order.should == ['van Gogh', '', 'Vincent', '']
        end
      
      end
    
      describe 'sorting' do
      
        it 'sorts by sort order by default' do
          [poe, utf, joe, plato].sort.should == [joe, plato, utf, poe]
        end
      
      end
    
    
    end
  
    describe Names do
    
      let(:gang_of_four) {
        Names.parse!('Erich Gamma and Richard Helm and Ralph Johnson and John Vlissides')
      }
      
      it { should_not be nil }
      it { should_not be_numeric }
    
      describe 'constructing' do
        
        it 'accepts a single name' do
          lambda { Names.new(joe) }.should_not raise_error
        end

        it 'accepts a single name as hash' do
          Names.new(:given => 'Jim').should have(1).names
        end
        
        it 'accepts two names' do
          Names.new(joe, poe).should have(2).names
        end

        it 'accepts two names as hash' do
          Names.new({:given => 'Jim'}, {:family => 'Jameson'}).should have(2).names
        end

        it 'accepts an array of names' do
          Names.new([joe, poe]).should have(2).names
        end
        
      end

      describe 'parsing' do
        it 'accepts a single name as a string' do
          Names.parse('Edgar A. Poe').should have(1).names
        end

        it 'accepts multiple names as a string' do
          Names.parse('Edgar A. Poe and Hawthorne, Nathaniel and Herman Melville').should have(3).names
        end

        it 'parses the passed-in family names' do
          Names.parse('Edgar A. Poe and Hawthorne, Nathaniel and Herman Melville').map { |n|
            n.values_at(:family) }.flatten.should == %w{ Poe Hawthorne Melville }
        end
        
        it '#parse returns nil on error' do
          Names.parse(23).should be_nil
        end
        
        it '#parse! raises an error on bad input' do
          expect { Names.parse!('A,B,C,D,E') }.to raise_error(ParseError)
        end
        
      end
      
      describe '#strip_markup' do
        
        it 'strips markup off string representation' do
          Names.new(markup).strip_markup.should == utf.to_s
        end
        
        it 'when using the bang! version, strips markup off each name part' do
          Names.new(markup).strip_markup![0].should == utf
        end
        
        
      end
      
      describe 'bang! methods' do
        it 'delegate to the individual names and return self' do
          Names.new(poe, plato, joe).upcase!.map(&:given).should == ['EDGAR ALLEN', 'PLATO', 'JOE']
        end        
      end
      
      [:never, :always, :contextually].each do |setting|
        setter = "delimiter_#{setting}_precedes_last!"
        predicate = "delimiter_#{setting}_precedes_last?"
        
        describe "##{setter}" do
          it 'sets the delimiter precedes last option accordingly' do
            Names.new.send(setter).send(predicate).should == true
          end
        end
      end
      
      describe '#delimiter_precedes_last' do
        it 'returns false by default' do
          Names.new(joe).should_not be_delimiter_precedes_last
        end

        it 'returns false by default for a single name' do
          Names.new(joe).should_not be_delimiter_precedes_last
        end

        it 'returns false by default for two names' do
          Names.new(joe, poe).should_not be_delimiter_precedes_last
        end

        it 'returns true for two names when option set to always' do
          Names.new(joe, poe).delimiter_always_precedes_last!.should be_delimiter_precedes_last
        end

        it 'returns true by default for three names' do
          Names.new(joe, poe, plato).should be_delimiter_precedes_last
        end

        it 'returns false for three names when option set to :never' do
          Names.new(joe, poe, plato).delimiter_never_precedes_last!.should_not be_delimiter_precedes_last
        end
      end
      
      describe '#to_bibtex' do
        
        describe 'when there is only a single name' do
          it 'prints the name in sort order' do
            Names.new(poe).to_bibtex.should == 'Poe, Edgar Allen'
          end
        end
        
        describe 'when there are two or more names' do
          it 'prints the names in sort order connected with the word "and"' do
            Names.new(poe, plato, humboldt).to_bibtex.should == 'Poe, Edgar Allen and Plato and Humboldt, Alexander von'
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
            gang_of_four.to_s.should match(/gamma.+helm/i)
            gang_of_four.to_s.should_not match(/johnson|vlissides/i)
          end
          
          it 'adds et-al at the end' do
            gang_of_four.to_s.should end_with('FOO')
          end
          
          it 'adds the delimiter before et-al when multiple names are printed' do
            gang_of_four.to_s.should end_with(', FOO')
          end

          it 'does not add the delimiter before et-al when only one name is printed' do
            gang_of_four.options[:'et-al-use-first'] = 1
            gang_of_four.to_s.should_not end_with(', FOO')
          end
          
        end
        
        it 'squeezes multiple whitespace between delimiter and connector' do
          Names.new(poe, humboldt, van_gogh, joe).to_s.should_not match(/\s{2}/)
        end 
      end
      
      describe '#each' do
        it 'returns an enumerator when no block given' do
          gang_of_four.each.should respond_to(:each)
        end
      end
      
      describe '#to_citeproc' do
        it 'returns a list of hashes' do
          gang_of_four.to_citeproc.map(&:class).uniq.should == [Hash]
        end
      end
      
      describe 'sorting' do
        it 'accepts other Names instance' do
          (Names.new(poe, plato) <=> Names.new(plato)).should equal(1)
          (Names.new(plato) <=> Names.new(poe, plato)).should equal(-1)
        end

        it 'accepts other list of names' do
          (Names.new(poe, plato) <=> [plato]).should equal(1)
          (Names.new(plato) <=> [poe, plato]).should equal(-1)
        end
      end

      describe '#inspect' do
        it 'returns a string' do
          gang_of_four.inspect.should be_a(String)
        end
      end
      
    end
    
  end
  
end