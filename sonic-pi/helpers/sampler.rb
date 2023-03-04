
@filter = lambda do |candidates|
  [candidates]
end

def drumkit(sample_name)

  if sample_name.instance_of?(Regexp)

    s = DRUMKITS, sample_name, @filter

  else
    s = DRUMKITS, sample_name

  end

  return s

end


class Collection
  
    attr_accessor :paths
      
      def initialize
      end



end
####
