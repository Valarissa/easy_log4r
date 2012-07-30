##
# Creates a Log4rLogger with no Outputters, or overwrites the default Logger provided by EasyLog4r::EasyLogger, removing it's Outputters
#
# This enables you to keep your log4r statements in your code without producing any output whatsoever.
#
module EasyLog4r::NullLogger

  ##
  # Included hook which nullifies the default Logger by removing its Outputters
  def self.included(base)
    EasyLog4r::Logger.add_logger(base, EasyLog4r::Logger.get_logger(base, :null))
  end
end
