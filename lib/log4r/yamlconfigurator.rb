class Log4r::YamlConfigurator
  alias :orig_decode_outputter :decode_outputter

  def self.decode_outputter( op )
    orig_decode_outputter(op)
    Outputter[op['name']].default = !!op['default']
  end
end
