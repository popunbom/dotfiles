#!/usr/bin/env ruby

require 'yaml'

def expand_env(value)
  value.gsub(/\$[A-Za-z0-9_]+/) { |env_var| ENV[env_var[1..]] }
end

def yes_no(prompt = "Confirmed ? (Y/n): ")
  while true
    printf prompt
    case gets.strip
    when /^Y$/
      return true
    when /^n$/, /^$/
      return false
    end
    puts "Please input 'Y' or 'n'"
  end
end

config_path = "#{__dir__}/config.yaml"

config = open(config_path) { |f| YAML.load(f.read) }
commands = config["symlinks"].map do |symlink|
  base_dir = File.dirname(config_path)
  src = File.absolute_path(expand_env(symlink["src"]), base_dir)
  dst = File.absolute_path(expand_env(symlink["dst"]), base_dir)
  "ln -s #{src} #{dst}"
end

puts <<EOS
=============================================================

██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝

=============================================================
=================== DOTFILES  INSTALLER =====================
=============================================================


EOS

puts "=============== EXECUTING COMMANDS ==============="
commands.each {|command| puts "$ #{command}"}
puts "=================================================="

if yes_no() then
  commands.each {|command| `#{command}`}
else
  puts "Abort -- exit."
end
