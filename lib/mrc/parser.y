class MRC::Parser

token EOF OPEN CLOSE IDENT WS STRING

rule

expressions
  : mustache { result = Mustache.new(*val) }
  ;

mustache
  : OPEN inMustache CLOSE { result = val[1]; }
  ;

inMustache
  : IDENT WS params
    { result = [Id.new(val.first), val.last] }
  | IDENT
    { result = Id.new(val.first) }
  ;

params
  : params WS param
    { result = val.first.children.push val.last }
  | param
    { result = Params.new(val) }
  ;

param
  : IDENT { result = Id.new(val.first) }
  | STRING { result = String.new(val.first) }
  ;
