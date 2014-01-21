namespace :test do
  require 'json'

  def load(file)
    JSON.parse File.open(file, 'r:UTF-8').read
  end

  def tags_for(json, feature)
    tags = []

    tags << "@#{json['mode']}"
    tags << "@#{feature}"

    tags
  end

  desc 'Fetch the citeproc-test repository and generate the JSON test files'
  task :init => [:clean] do
    system "hg clone https://bitbucket.org/bdarcus/citeproc-test test"
    system "cd test && python2.7 processor.py --grind"
  end

  desc 'Remove the citeproc-test repository'
  task :clean do
    system "rm -rf test"
  end

  desc 'Delete all generated CSL feature tests'
  task :clear do
    Dir['features/**/*'].sort.reverse.each do |path|
      unless path =~ /features\/support/
        if File.directory?(path)
          system "rmdir #{path}"
        else
          system "rm #{path}"
        end
      end
    end
  end

  task :convert => [:clear] do
    features = Dir['test/processor-tests/machines/*.json'].group_by { |path|
      File.basename(path).split(/_/, 2)[0]
    }

    features.each_key do |feature|
      system "mkdir features/#{feature}"

      features[feature].each do |file|
        json, filename = load(file), File.basename(file, '.json').split(/_/, 2)[-1]

        tags = tags_for(json, feature)
        name = filename.gsub(/(\p{Ll})(\p{Lu})/, '\1 \2')

        if json['mode'] == 'bibliography' && !json['bibsection'] && !json['bibentries']
          File.open("features/#{feature}/#{filename}.feature", 'w:UTF-8') do |out|
            out << "Feature: #{feature} #{name}\n"
            out << "  As a CSL cite processor hacker\n"
            out << "  I want the test #{File.basename(file, '.json')} to pass\n\n"
            out << "  " << tags.join(' ') << "\n"
            out << "  Scenario: #{name}\n"

            out << "    Given the following style:\n"
            out << "    \"\"\"\n"

            json['csl'].each_line do |line|
              out << '    ' << line << "\n"
            end
            out << "    \"\"\"\n"

            #out << "    And the following input:\n"
            #out << "    \"\"\"\n"

            #json['input'].each_line do |line|
            #  out << '    ' << line << "\n"
            #end

            #out << "    \"\"\"\n"
          end
        end
      end
    end
  end


end
