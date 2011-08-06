# Taken from https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/class/attribute_accessors.rb, minus (options = syms.extract_options!)
class Class
  def cattr_reader(*syms)
    syms.each do |sym|
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        unless defined? @@#{sym}
          @@#{sym} = nil
        end

        def self.#{sym}
          @@#{sym}
        end
      EOS
      
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        def #{sym}
          @@#{sym}
        end
      EOS
    end
  end

  def cattr_writer(*syms)
    syms.each do |sym|
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        unless defined? @@#{sym}
          @@#{sym} = nil
        end

        def self.#{sym}=(obj)
          @@#{sym} = obj
        end
      EOS
      
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        def #{sym}=(obj)
          @@#{sym} = obj
        end
      EOS
      
      self.send("#{sym}=", yield) if block_given?
    end
  end

  def cattr_accessor(*syms, &blk)
    cattr_reader(*syms)
    cattr_writer(*syms, &blk)
  end
end