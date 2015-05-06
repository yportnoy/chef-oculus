packages = value_for_platform_family(
  'debian' => %w(ruby ruby-dev),
  %w(fedora rhel) => %w(ruby ruby-devel)
)

packages.each do |p|
  package p
end
