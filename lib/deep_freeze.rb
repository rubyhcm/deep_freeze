# frozen_string_literal: true

require_relative "deep_freeze/version"

module DeepFreeze
  # TODO: Cyclic references will cause infinite recursion. Fix this.
  def deep_freeze(obj)
    case obj
    when String, Numeric, Symbol, NilClass, TrueClass, FalseClass
      obj.freeze
    when Hash
      obj.each { |k, v| deep_freeze(k); deep_freeze(v) }
      obj.freeze
    when Array
      obj.each { |el| deep_freeze(el) }
      obj.freeze
    else
      raise "Can't deep freeze objects of class #{obj.class}"
    end
  end
end
