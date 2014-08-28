require_relative './lib/cloud_servers_dns'

Gem::Specification.new do |s|
  s.add_runtime_dependency 'fog'
  s.add_runtime_dependency 'rubydns'
  s.add_runtime_dependency 'process-daemon'
  s.name = 'cloud-servers-dns'
  s.version = CloudServersDNS::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Dusty Jones']
  s.email = ['dusty@dustyjones.com']
  s.homepage = 'http://github.com'
  s.summary = 'DNS Provider for your Rackspace Cloud Servers'
  s.description =<<EOF
Creates a DNS Provider to resolve cloud servers by name, can 
be configured to return internal addresses for internal requests,
external addresses for external requests. Supports wildcard subdomaining
of cloud servers.
EOF

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f)}
  s.require_paths = ['lib']
  s.license = 'MIT'
end
