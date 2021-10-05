require_relative 'support/global_instances/carts_instances.rb'
require_relative 'support/global_instances/login_instances.rb'
require_relative 'support/global_instances/products_instances.rb'
require_relative 'support/global_instances/users_instances.rb'

require_relative 'requests/carts_requests'
require_relative 'requests/login_requests'
require_relative 'requests/products_requests'
require_relative 'requests/users_requests'

require_relative 'support/utils'

require 'faker'
require 'json_matchers/rspec'

RSpec.configure do |config|
    config.default_path = 'spec/tests'
end

JsonMatchers.schema_root = 'spec/fixtures/schemas'