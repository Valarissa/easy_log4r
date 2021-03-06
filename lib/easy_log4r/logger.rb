##
# Class that creates Log4r::Loggers with some basic defaults and also modifies base classes to referece said Loggers.
#
class EasyLog4r::Logger
  require 'log4r'

  include Log4r

  ##
  # Adds log4r class variable, as well as Base::log4r and Base#log4r
  def self.add_logger(base, logger)
    base.class_variable_set(:@@log4r, logger)
    base.class_eval do 
      def log4r; self.class.log4r; end
      def self.log4r; class_variable_get(:@@log4r); end
    end
  end

  ##
  # Provides the default Loggers, which are null_loggers with the default outputters.
  def self.default_logger(name)
    logger = null_logger(name)
    logger.outputters = default_outputters

    return logger
  end

  ##
  # Creates or returns default outputters.
  #
  # Those outputters are a Log4r::StdoutOutputter and a Log4r::StderrOutputter, both of which have a default Log4r::Formatter
  def self.default_outputters
    return @outputters if @outputters

    @outputters = []
    @outputters << configured_default_outputters
    @outputters << standard_outputters if @outputters.empty?
    @outputters.flatten!

    return @outputters
  end

  ##
  # Takes a name and Logger class and gives back a predefined logger, or a new instance of the given Log4r:: class
  def self.default_outputter(name, clas)
    clas = Log4r.instance_eval{ clas }
    out = Log4r::Outputter[name]
    out = clas.new(name, :formatter => default_formatter) unless out

    return out
  end

  ##
  # Gathers all Log4r::Outputters defined in the user defined configuration file.
  def self.configured_default_outputters
    Log4r::Outputter.default_outputters
  end

  ##
  # Defines two standard outputters, one which prints to stdout at all levels, and one which prints to stderr for error and fatal levels.
  def self.standard_outputters
    @outputters << default_outputter('formatted_stdout', StdoutOutputter)
    @outputters << default_outputter('formatted_stderr', StderrOutputter)
    Log4r::Outputter['formatted_stderr'].level = :error
  end

  ##
  # Creates or returns the default formatter.
  #
  # The formatter is a Log4r::PatternFormatter with the following pattern:
  #   "[%l] %d @@%c :: %m"
  #
  # For example:
  #   Base.log4r.info("This is only a test")
  #   => [INFO] 2012-07-30 12:00:00 PM @@Base :: This is only a test
  def self.default_formatter
    return @formatter if @formatter
    @formatter = Log4r::PatternFormatter.new(:pattern => "[%l] %d @@%c :: %m")

    return @formatter
  end

  ##
  # Creates a Log4r::Logger with the given name and clears all Outputters
  def self.null_logger(name)
    logger = Log4r::Logger.new(name)
    logger.outputters = []

    return logger
  end

  ##
  # Given a Class, this will return either an existing Log4r::Logger, that could be defined via XML or YAML options, or a fresh new logger, that has the name of the class, as represented by Class.to_s, as its name. 
  #
  # If the second option is given any value which resolves to true, it will provide a Log4r::Logger with no Outputters.
  def self.get_logger(base, null=false)
    clas = base.to_s
    logger = null ? null_logger(clas) : Log4r::Logger[clas]
    return logger || default_logger(clas)
  end
end
