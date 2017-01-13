# Require core library
require 'middleman-core'

# Extension namespace
module MiddlemanZip
  class Extension < ::Middleman::Extension
    option :file_types, %w(.html), 'What file types to add to the zip'

    def initialize(app, options_hash={}, &block)
      # Call super to build options from the options_hash
      super

      # Require libraries only when activated
      require 'zip'

      # set up your extension
      app.after_build do |builder|
        files = ::Middleman::Util.all_files_under(config[:build_dir])

        options = extensions[:zip].options

        files.each do |file|
          next unless file.extname == '.html'
          dir, base = file.split

          zip_file = "#{dir.to_s}/#{base.to_s.gsub('.html', '.zip')}"

          builder.thor.say_status :zip, zip_file

          Zip.continue_on_exists_proc = true

          Zip::File.open(zip_file, Zip::File::CREATE) do |zf|
            options.file_types.each do |ext|
              file_name = "#{base.to_s.gsub('.html', ext)}"
              zf.add(file_name, "#{dir}/#{file_name}")
            end
          end
        end
      end

    end

    # A Sitemap Manipulator
    def manipulate_resource_list(resources)
      res = []

      files = ::Middleman::Util.all_files_under(app.config[:build_dir])

      files.each do |file|
        next unless file.extname == '.html'

        file_path = file.to_s.split('/')
        file_path.shift
        zip_file = file_path.join('/').gsub('.html', '.zip')

        source_file = File.join(app.root, app.config[:build_dir], zip_file)

        if File.exist? source_file
          res << Middleman::Sitemap::Resource.new(app.sitemap, zip_file, source_file)
        end
      end

      resources + res
    end

  end
end
