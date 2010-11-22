module MRC
class Tokenizer < Parser

rule

"(\\.|[^\\"])*"         { [:STRING, text] }
[A-Za-z]+               { [:IDENT, text] }
\{\{\s*                 { [:OPEN, text] }
\s*\}\}                 { [:CLOSE, text] }
\s+                     { [:WS, text] }

end
end
