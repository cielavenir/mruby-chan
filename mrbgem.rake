MRuby::Gem::Specification.new('mruby-enum-lazy') do |spec|
  spec.license = 'MIT'
  spec.author  = 'cielavenir'
  spec.summary = 'Bidirectional channel like the Golang chan object'
  spec.add_dependency('mruby-fiber', :core => 'mruby-fiber')
  spec.add_dependency('mruby-enumerator', :core => 'mruby-enumerator')
end
