class Log4r::YamlConfigurator
  class << self
    alias :orig_decode_outputter :decode_outputter
  end

  def self.decode_outputter( op )
    orig_decode_outputter(op)
    Outputter[op['name']].default = !!op['default']
  end
end
