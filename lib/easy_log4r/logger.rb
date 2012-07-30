class EasyLog4r::Logger
  require 'log4r'
  include Log4r

  def self.add_logger(base, logger)
    base.class_variable_set(:@@log4r, logger)
    base.instance_eval{ def log4r; @@log4r; end }
    base.class_eval{ def log4r; @@log4r; end }
  end

  def self.default_logger(name)
    logger = null_logger(name)
    formatter = Log4r::PatternFormatter.new(:pattern => "[%l] %d %c :: %m")
    logger.outputters = [Log4r::StdoutOutputter.new(:formatter => formatter),
                         Log4r::StderrOutputter.new(:formatter => formatter)]
    return logger
  end

  def self.null_logger(name)
    logger = Log4r::Logger.new(name)
    logger.outputters = []

    return logger
  end

  def self.get_logger(base, null=false)
    clas = base.to_s
    logger = null ? null_logger(clas) : Log4r::Logger[clas]
    return logger || default_logger(clas)
  end
end
