class Log4r::Configurator
  alias :orig_decode_outputter :decode_outputter

  def self.decode_outputter(e)
    orig_decode_outputter(e)
    Outputter[e.value_of('name')].default = !!e.value_of('default')
  end
end
