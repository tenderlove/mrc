require 'mrc/parser'
require 'mrc/tokenizer'

module MRC
  VERSION = '1.0.0'

  class Node     < Struct.new(:children); end
  class Mustache < Node; end
  class Id       < Node; alias :name :children; end
  class String   < Node; end
  class Params   < Node; end
end
