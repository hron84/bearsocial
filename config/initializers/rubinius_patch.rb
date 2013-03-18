unless Pathname.new(__FILE__).respond_to? :to_str
  class Pathname
    def to_str
      self.to_s
    end
  end
end
