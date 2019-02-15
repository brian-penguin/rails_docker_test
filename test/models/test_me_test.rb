require "test_helper"

class TestMeTest < ActiveSupport::TestCase
  def setup
    @test_me = TestMe.new
  end

  test "#foo" do
    assert(@test_me.foo == "bar")
  end

  test "#add1" do
    assert(@test_me.add1(1) == 2)
    assert(@test_me.add1(3) == 4)
  end
end
