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

  def test_parser
    tokenizer = MRC::Tokenizer.new
    tree = tokenizer.scan_str('{{ foo bar "baz" }}')
    assert_equal 2, tree.children.length
    assert_equal 'foo', tree.children.first.name

    params = tree.children[1]
    assert_equal 2, params.length
  end

  class Runtime
    def foo *args
      args
    end
  end

  def test_interpretor
    tokenizer = MRC::Tokenizer.new
    tree = tokenizer.scan_str('{{ foo bar "baz" }}')
    interpretor = MRC::Visitors::Interpreter.new Runtime.new
    result = interpretor.accept(tree)
    assert_equal [:bar, '"baz"'], result
  end
end
