require 'test_helper'

class ScriptTest < ActiveSupport::TestCase
  def test_before_validation_replaces_non_alphanumeric_characters
    script = Script.new({:name => 'foo$bar baz@123'})
    script.before_validation
    assert_equal('foo-bar_baz-123', script.name)
  end
end
