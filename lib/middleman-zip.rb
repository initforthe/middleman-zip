require "middleman-core"

Middleman::Extensions.register :zip do
  require "middleman-zip/extension"
  ::MiddlemanZip::Extension
end
