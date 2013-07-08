packages = value_for_platform_family(
  "debian" => %w{ ruby ruby-dev rubygems },
  %w{ fedora rhel } => %w{ ruby ruby-devel rubygems }
)

packages.each do |p|
  package p
end
