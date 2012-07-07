# Requires rake, psych, mustache, less, coffee-script, therubyracer, and jsmin
html_files = "src/templates/*.html"

css_files = "src/static/css/*.less"
css_output = "bin/static/style.css"

js_files = "src/static/js/*.coffee"
js_output = "bin/static/script.js"

task :default => [:build, :push]

task :build => [:setup_directory, :lazy_compile, :templates]

task :setup_directory do
  mkpath "bin/static/"
  # Link is relative to bin/static/
  if not File.symlink? "bin/static/images"
    symlink "../../src/static/images", "bin/static/images"
  end
end

def check_file_updates(sources, destination, task)
  return Rake::Task[task].invoke unless File.exist? destination

  # Test last compile
  last_mod = File.stat(destination).mtime

  # Test each file
  Dir[sources].each do |file|
    if File.stat(file).mtime > last_mod
      return Rake::Task[task].invoke
    end
  end
end

task :lazy_compile do
  check_file_updates css_files, css_output, :compile_css
  check_file_updates js_files, js_output, :compile_js
end

task :compile_css do
  require 'less'

  parser = Less::Parser.new
  puts "Compiling css to #{ css_output }"
  File.open css_output, "w+" do |f|
    Dir[css_files].each do |sheet|
      puts "  #{ sheet }"
      f.write parser.parse(File.read(sheet)).to_css :compress => true
    end
  end
end

task :compile_js do
  require 'coffee-script'

  puts "Compiling js to #{ js_output }"
  File.open js_output, "w+" do |f|
    Dir[js_files].each do |script|
      puts "  #{ script }"
      f.write CoffeeScript.compile File.read(script)
    end
  end
end

task :minify_js do
  require 'jsmin'

  puts "Minifying js..."
  minified = JSMin.minify File.read(js_output)
  File.open js_output, "w+" do |f|
    f.write minified
  end
end

task :templates do
  require 'mustache'

  puts "Compiling templates..."
  dir, match = File.split(html_files)
  path = Dir.pwd
  # We have to change directorys for Mustache includes
  cd dir
  Dir[match].each do |template|
    puts "  #{ template }"
    base = File.basename(template)
    File.open "#{ path }/bin/#{ base }", "w+" do |f|
      f.write Mustache.render(File.read(template))
    end
  end
  cd path
end

task :push => [:minify_js, :rsync]

task :rsync do
  require 'psych'
  config = Psych.load(File.read("config.yml"))
  config = config[:production]

  puts "Pushing to production..."
  puts `rsync -rL bin/* "#{ config[:user] }@#{ config[:host] }:#{ config[:directory] }"`
end
