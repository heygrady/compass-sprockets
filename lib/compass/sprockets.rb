require "compass/sprockets/version"

module Compass
  module Sprockets
    # register the framework
    Compass::Frameworks.register("sprockets", :path => "#{File.dirname(__FILE__)}/..")

    # register the custom config variables
    Compass::Configuration.add_configuration_property(:javascripts_src_dir, "Location of JavaScript source files for use with Sprockets") do
      "javascripts/src"
    end

    # register a custom watch
    Compass::Configuration::Data.watch Compass.configuration.javascripts_src_dir + "/**/*" do |project_dir, relative_path|
      if File.exists?(File.join(project_dir, relative_path))
        # configure environment
        environment = Sprockets::Environment.new(project_dir)
        environment.append_path(Compass.configuration.javascripts_src_dir) #Compass.configuration.javascripts_dir + "/src"
        environment.js_compressor = Sprockets::LazyCompressor.new { Sprockets::Compressors.registered_js_compressor(:uglifier) }
        
        # configure the static compiler
        compiler = Sprockets::StaticCompiler.new(
          environment,
          Compass.configuration.javascripts_dir,
          [/^([\w-]+\/)?[^_]\w+\.(js|coffee)$/],
          :manifest_path => Compass.configuration.javascripts_dir,
          :digest => false,
          :manifest => false,
          :zip_files => /a^/
          )
        compiler.compile
      end
    end
  end
end