#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'
require 'set'

a = `awk '/^yes / {print $2}' package-spec`
included = Set[]
a.lines.each do |name|
  included.add name[0..-2]
end
a = YAML.load_stream(File.read('packages-full.yaml')).filter do |package|
  included.member? package['name']
end

File.open('packages.yaml', 'w') do |out|
  for package in a
    YAML.dump(package, out)
  end
end
# exec 'cat packages.yaml'
exec 'make build'
