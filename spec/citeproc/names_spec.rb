# -*- coding: utf-8 -*-

require 'spec_helper'

module CiteProc
	
	describe Name do
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


		it { should_not be_nil }

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
		
		describe 'displaying' do
			
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
				
			end
			
			describe '#display order' do
			end
			
		end
		
	end
	
	describe Names do
	end
	
end