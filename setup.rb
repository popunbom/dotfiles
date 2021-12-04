#!/usr/bin/env ruby

require 'yaml'

def expand_env(value)
  value.gsub(/\$[A-Za-z0-9_]+/) { |env_var| ENV[env_var[1..]] }
end

config = open('./config.yaml') { |f| YAML.load(f.read) }

config["symlinks"].each do |symlink|
  src = File.absolute_path(expand_env(symlink["src"]))
  dst = File.absolute_path(expand_env(symlink["dst"]))
  printf("Create symlink: %s --> %s\n", src, dst)
  `ln -s #{src} #{dst}`
end
