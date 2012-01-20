require "rake/sprocketstask"
require "./static_compiler.rb"

# @see http://guides.rubyonrails.org/asset_pipeline.html
@paths = ["css", "js", "scss"]

# @see https://github.com/rails/sprockets-rails/blob/master/lib/sprockets/rails/railtie.rb#L77
def expand_js_compressor(sym)
  case sym
  when :closure
    require 'closure-compiler'
    Closure::Compiler.new
  when :uglifier
    require 'uglifier'
    Uglifier.new
  when :yui
    require 'yui/compressor'
    YUI::JavaScriptCompressor.new
  else
    sym
  end
end

# @see https://github.com/rails/sprockets-rails/blob/master/lib/sprockets/rails/railtie.rb#L93
def expand_css_compressor(sym)
  case sym
  when :yui
    require 'yui/compressor'
    YUI::CssCompressor.new
  else
    sym
  end
end

# @see https://github.com/sstephenson/sprockets/blob/master/lib/sprockets/environment.rb#L44
def get_exts
  # look for all the files that Sprockets can handle
  @engines = Sprockets.engines
  exts = ['js', 'css']
  @engines.each do |ext, klass|
    exts += [ext[1..-1]]
  end
  return exts
end

def compile(base)
  # look for all the files that Sprockets can handle
  precompile = [/application.(css|js)$/]
  exts = get_exts
  precompile += [ Regexp.new( "^([\\w-]+\\/)?[^_]\\w+\\.(" + exts.join("|")+")$" ) ]

  # set up the env
  @env = Sprockets::Environment.new(".") do |env|
    #@paths.each do |path|
    #  env.append_path(path)
    #end
    env.append_path(base)

    # @see https://github.com/rails/sprockets-rails/blob/master/lib/sprockets/rails/railtie.rb#L69
    env.js_compressor = expand_js_compressor(:uglifier)
    #env.css_compressor = expand_css_compressor(:yui)
  end

  compiler = Sprockets::StaticCompiler.new(
    @env,
    './assets/' + base,
    precompile,
    :manifest_path => './' + base,
    :digest => false,
    :manifest => true)

  compiler.compile
end

task :precompile do
  @paths.each do |path|
    compile(path)
  end
end

# @see https://gist.github.com/222571
task :watch, :src_folder do |t, args|
  require "fssm"
  srcFolder = args.src_folder.nil? ? "." : args.src_folder

  puts ">>> Watching #{srcFolder} for changes. Press Ctrl-C to Stop."
  #compile

  # @see https://github.com/sstephenson/sprockets/blob/master/lib/sprockets/environment.rb#L44
  # @see https://github.com/chriseppstein/compass/blob/stable/lib/compass/commands/watch_project.rb#L98
  FSSM.monitor do |monitor|
    @paths.each do |load_path|
      compile(load_path)
      load_path = "./" + load_path
      next unless File.directory?(load_path)
      monitor.path load_path do |path|
        path.glob '**/*.{' + get_exts.join(',') +'}'

        path.update do |base, relative|
          puts ">>> Change detected to: #{relative}"
          compile(File.basename(base))
        end
        path.create do |base, relative|
          puts ">>> New file detected: #{relative}"
          compile(File.basename(base))
        end
        path.delete do |base, relative|
          puts ">>> File Removed: #{relative}"
          compile(File.basename(base))
        end
      end
    end
  end
 
  FSSM.monitor(srcFolder, "**/*.js") do
    update {|base, relative| update_file(relative)}
  end
end
