##
# Base Class for EasyLog4r. Standard includes for the rest of the gem.
#
# To use EasyLog4r, just include the gem in your Gemfile, then drop the following into your class:
#   include EasyLog4r::EasyLogger
#
# This produces a log4r method on the class and any instance that can be used to access a Log4r::Logger with some simple defaults.
#
module EasyLog4r
  require 'easy_log4r/logger'
  require 'easy_log4r/easy_logger'
  require 'easy_log4r/null_logger'
  require 'log4r/outputter'
  require 'log4r/configurator'
  require 'log4r/yamlconfigurator'
end
