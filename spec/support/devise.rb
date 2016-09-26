RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => [:feature, :controller]
end
