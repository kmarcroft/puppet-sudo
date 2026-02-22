require 'serverspec'

set :backend, :exec

RSpec.configure do |c|
  c.formatter = :documentation
end
