module EasyLog4r::EasyLogger
  def self.included(base)
    EasyLog4r::Logger.add_logger(base, EasyLog4r::Logger.get_logger(base))
  end
end
