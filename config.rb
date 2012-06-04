# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path = "/"
public_dir = ''
css_dir = public_dir + 'stylesheets'
images_dir = public_dir + '/images'

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

# A Ruby interface to YUI Compressor for minifying JavaScript and CSS assets
# See https://github.com/sstephenson/ruby-yui-compressor
def load_yui_compressor
  require "yui/compressor"
  on_stylesheet_saved do |filename|
    unless !filename.match(/Screen\.css/)
      compressedFile = filename.sub(/\.css/, '-min.css')
      compressor = YUI::CssCompressor.new
      File.open(filename, "r") do |source|
        File.open(compressedFile, 'w') do |f| 
          f.write(compressor.compress(source))
        end
      end
    end
  end
rescue LoadError
  print 'yui-compressor not loaded!'
end
load_yui_compressor

## Use growl notification after compile if the gem is installed
def load_compass_growl
  require 'compass-growl'
rescue LoadError
  false
end
load_compass_growl
