require 'spec'
require 'activerecord'

Dir.glob(File.dirname(__FILE__) + '/../lib/spec/rails/matchers/*.rb').each do |f|
  require f
end

include Spec::Rails::Matchers

# Dir.glob(File.dirname(__FILE__) + '/../rspec_on_rails/**/*.rb').each do |f|
#   require f
# end
