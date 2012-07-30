module EasyLog4r::NullLogger
  def self.included(base)
    EasyLog4r::Logger.add_logger(base, EasyLog4r::Logger.get_logger(base, :null))
  end
end
