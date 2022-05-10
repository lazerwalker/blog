require 'fileutils'
require 'imgkit'

module Filter
  def self.process(site, payload)
    site.collections['posts'].docs.each do |post|

      # Set the path where the copied content will live
      path = './_previews/' + post.data['slug'] + '.md'

      # Copy the content of the post to the preview collection
      File.write(path, File.read(post.path))

      # Create a new document in the preview collection
      preview_doc = Jekyll::Document.new(
        path,
        {site: site, collection: site.collections['previews']}
      )

      preview_doc.read

      # Set the layout to preview
      preview_doc.data['layout'] = 'preview'

      # Add document to the collection
      site.collections['previews'].docs << preview_doc

    end
  end
end

Jekyll::Hooks.register :site, :post_read do |site, payload|
  # If the site is being served locally
  # skip generating previews
  # Otherwise there'll be an endless loop of previews being
  # written and regenerated
  if !site.config['serving']
    Filter.process(site, payload)
  end
end

module RemovePreviews
    def self.process(site, payload)
      FileUtils.rm_rf("./_previews/.", secure: true)
    end
  end

  module Previews
    def self.process(site, payload)
      begin
        # On first run it's necessary to create the previews
        # directory in the generated site
        FileUtils.mkdir('./_site/assets/images/previews')
      rescue
      end
  
      # Loop through all the previews
      site.collections['previews'].docs.each do |p|
        slug = p.data['slug']
  
        # If the image already exists skip,
        # in order to speed up generation
        # To regenerate the preview, delete the file
        if !File.exists?('./images/previews/' + slug + '.png')
  
          # Read the generated html for the preview
          # And set imgkit up for generating a
          # 600x315 image at 75 quality
          kit = IMGKit.new(
            File.read('./_site/previews/' + slug + '/index.html'),
            quality: 75,
            width: 600,
            height: 315
          )
  
          # Attach the local stylesheet for wkhtmltoimage to pick up
          kit.stylesheets << './_site/assets/css/main.css'
  
          # Then save the image to the previews directory
          kit.to_file('./images/previews/' + slug + '.png')
  
          # This step requires pngquant
          # It removes color depth from images and reduces their
          # size to about a third
          `pngquant #{'./images/previews/' + slug + '.png'} -o #{'./images/previews/' + slug + '.png'} -f`
  
          # And copy it to the generated site
          FileUtils.cp(
            './images/previews/' + slug + '.png',
            './_site/assets/images/previews/' + slug + '.png'
          )
        end
      end
    end
  end
  
  # Add a hook that's run after html is written
  Jekyll::Hooks.register :site, :post_write do |site, payload|
  
    # Check if the site is being built or served locally
    if !site.config['serving']
      Previews.process(site, payload)
    end
  end