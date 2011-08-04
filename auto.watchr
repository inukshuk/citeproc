
# Rules
# --------------------------------------------------
watch( '^spec/.+_spec.rb' ) { |m| rspec m[0] }
watch( '^lib/(.*)\.rb' ) { |m| rspec "spec/#{m[1]}_spec.rb" }

# Signal Handling
# --------------------------------------------------
Signal.trap('QUIT') { rspec 'spec' } # Ctrl-\
Signal.trap('INT' ) { abort("\n") } # Ctrl-C

def rspec (*paths)
	paths = paths.reject { |p| !File.exists?(p) }
	run "bundle exec rspec --tty -c #{ paths.empty? ? 'spec' : paths.join(' ') }"
end

def run (cmd)
  puts cmd
  system cmd
end
