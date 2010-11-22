require 'mrc/parser'
require 'mrc/tokenizer'
require 'mrc/visitors/interpreter'

module MRC
  VERSION = '1.0.0'

  class Node     < Struct.new(:children); end
  class Mustache < Node; end
  class Id       < Node; alias :name :children; end
  class String   < Node; alias :value :children; end
  class Params   < Node; end
end
