##
# EasyLogger
#
# This class is what sets up the EasyLog4r Logger in your class when you include it in the class.
#
module EasyLog4r::EasyLogger

  ##
  # Included hook which calls EasyLog4r::Logger#add_logger
  def self.included(base)
    EasyLog4r::Logger.add_logger(base, EasyLog4r::Logger.get_logger(base))
  end
end
