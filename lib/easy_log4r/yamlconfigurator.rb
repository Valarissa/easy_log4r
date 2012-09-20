##
#  Extension of base Log4r::YamlConfigurator to enable decoding of a `default`
#  attribute in the Yaml definition.
#
class Log4r::YamlConfigurator
  class << self
    alias :orig_decode_outputter :decode_outputter
  end

  ##
  # Decodes an outputter as normal, but also sets @default if it was defined in the given configuration file.
  def self.decode_outputter( op )
    orig_decode_outputter(op)
    Log4r::Outputter[op['name']].default = !!op['default']
  end
end
