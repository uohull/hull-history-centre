Dir[File.join(File.dirname(__FILE__), '**', '*.rb')].each do |file|
  require file
end

module Sirsi
end
