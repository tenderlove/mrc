require "test/unit"
require "mrc"

class TestMrc < Test::Unit::TestCase
  def test_tokenizer
    tokenizer = MRC::Tokenizer.new
    tokenizer.scan_setup('{{ foo bar "baz" }}')
    tokens = []
    while token = tokenizer.next_token
      tokens << token
    end
    expected = [[:OPEN, "{{ "], [:IDENT, "foo"], [:WS, " "], [:IDENT, "bar"], [:WS, " "], [:STRING, "\"baz\""], [:CLOSE, " }}"]]
    assert_equal expected, tokens
  end
end
