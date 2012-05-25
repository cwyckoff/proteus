spec = Gem::Specification.new do |s|
  s.name = 'proteus'
  s.version = '0.0.1'
  s.date = '2012-05-15'
  s.summary = 'Proteus is a tool to transform fields and values in a hash'
  s.email = "cwyckoff@alliancehealth.com"
  s.homepage = "http://github.com/cwyckoff/proteus"
  s.description = 'Proteus is a tool to transform fields and values in a hash'
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--main", "README.rdoc", "--title", "Proteus - a simple tool to transform fields in new and exciting ways"]
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.authors = ["Chris Wyckoff", "Josh Fenio"]
  s.add_dependency('activesupport')
  s.files = ["init.rb",
             "README.rdoc",
             "LICENSE.txt",
             "lib/proteus.rb",
             "lib/core_ext/time.rb",
             "lib/exceptions.rb",
             "lib/transformations/add_timestamp.rb",
             "lib/transformations/blank.rb",
             "lib/transformations/clone.rb",
             "lib/transformations/concatenate.rb",
             "lib/transformations/date.rb",
             "lib/transformations/date_time.rb",
             "lib/transformations/interpolate.rb",
             "lib/transformations/lowercase.rb",
             "lib/transformations/map.rb",
             "lib/transformations/phone.rb",
             "lib/transformations/prepop.rb",
             "lib/transformations/prepper.rb",
             "lib/transformations/remove.rb",
             "lib/transformations/state.rb",
             "lib/transformations/truncate.rb",
             "lib/transformations/uppercase.rb",
	     "lib/transformations/value_map.rb",
             "lib/transformations/zip.rb"]
end
