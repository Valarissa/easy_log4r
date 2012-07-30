require 'helper'

class BaseClass
end

class TestEasyLogger < Test::Unit::TestCase
  
  def include_logger
    BaseClass.class_eval{ include EasyLog4r::EasyLogger }
  end

  should "create log4r method on base class" do
    include_logger
    assert_respond_to BaseClass, :log4r
  end

  should "create log4r method on class instance" do
    include_logger
    assert_respond_to BaseClass.new, :log4r
  end
end
