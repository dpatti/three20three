# Requires rake, psych, mustache, less, coffee-script, therubyracer, and jsmin
html_files = "src/templates/*.html"

css_files = "src/static/css/*.less"
css_output = "bin/static/style.css"

js_files = "src/static/js/*.coffee"
js_libraries = "src/static/js/lib/*.js"
js_output = "bin/static/script.js"

task :default => [:build]

task :build => [:setup_directory, :lazy_compile, :templates]

task :setup_directory do
  mkpath "bin/static/"
  # Link is relative to bin/static/
  if not File.symlink? "bin/static/images"
    symlink "../../src/static/images", "bin/static/images"
  end
end

def check_file_updates(sources, destination, task)
  return Rake::Task[task].execute unless File.exist? destination

  # Test last compile
  last_mod = File.stat(destination).mtime

  # Test each file
  Dir[sources].each do |file|
    if File.stat(file).mtime > last_mod
      return Rake::Task[task].execute
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

  output = ""
  Dir[css_files].each do |sheet|
    puts "  #{ sheet }"
    output << parser.parse(File.read(sheet)).to_css(:compress => true)
  end

  File.open css_output, "w+" do |f|
    f.write output
  end
end

task :compile_js do
  require 'coffee-script'

  puts "Compiling js to #{ js_output }"
  output = ""
  # Libraries
  Dir[js_libraries].each do |lib|
    output << File.read(lib)
  end
  # Local stuff
  Dir[js_files].each do |script|
    puts "  #{ script }"
    output << CoffeeScript.compile(File.read(script), :no_wrap => true)
  end

  File.open js_output, "w+" do |f|
    f.write output
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

task :push => [:build, :minify_js, :rsync]

task :rsync do
  require 'psych'
  config = Psych.load(File.read("config.yml"))
  config = config[:production]

  puts "Pushing to production..."
  puts `rsync -rL bin/* "#{ config[:user] }@#{ config[:host] }:#{ config[:directory] }"`
end

task :serve => [:build, :start_server]

task :start_server do
  require 'webrick'
  require 'mime/types'

  # Starts a server for development use
  servlet = Class.new(WEBrick::HTTPServlet::AbstractServlet) do
    def do_GET(req, res)
      dir, file = File.split req.path
      file = "index.html" if file == "/" or file == ""

      case file
      when /(\.css|\.js)/
        # Make sure our assets are up to date
        Rake::Task[:lazy_compile].execute
      when /\.html/
        # See if we need to update the file
        Rake::Task[:templates].execute
      end

      if File.file? "bin/#{ dir }/#{ file }"
        res.status = 200
        res['Content-Type'] = MIME::Types.type_for(file).first.content_type
        res.body = File.read "bin/#{ dir }/#{ file }"
      else
        res.status = 404
        res.body = "File not found: #{ req.path }"
      end
    end
  end

  server = WEBrick::HTTPServer.new(:Port => 8338)
  server.mount('/', servlet)

  %w( INT TERM ).each do |sig|
    trap(sig) { server.shutdown }
  end

  server.start
end
