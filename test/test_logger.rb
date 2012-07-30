require 'helper'

class BaseClass
end

class TestLogger < Test::Unit::TestCase
  context "self.get_logger" do
    should "return a Log4r::Logger" do
      assert EasyLog4r::Logger.get_logger(BaseClass).is_a?(Log4r::Logger)
    end

    should "return a Log4r::Logger with the name 'BaseClass'" do
      logger = EasyLog4r::Logger.get_logger(BaseClass)
      assert logger.name == 'BaseClass'
    end

    should "return a Log4r::Logger with no Outputters if specified" do
      logger = EasyLog4r::Logger.get_logger(BaseClass, :null)
      assert logger.outputters.length == 0
    end

    should "return an existing Log4r::Logger if one exists" do
      orig_logger = Log4r::Logger.new('BaseClass')
      logger = EasyLog4r::Logger.get_logger(BaseClass)
      assert logger == orig_logger
    end
  end

  context "self.default_logger" do
    should "return a Log4r::Logger with outputters" do
      logger = EasyLog4r::Logger.default_logger('BaseClass')
      assert logger.outputters.length != 0
    end
  end

  context "self.null_logger" do
    should "return a Log4r::Logger with no outputters" do
      logger = EasyLog4r::Logger.null_logger('BaseClass')
      assert logger.outputters.length == 0
    end
  end
end
