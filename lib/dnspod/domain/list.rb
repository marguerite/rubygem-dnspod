module DNSPod
  # List all the domains you have
  class DomainList
    def initialize(type = 'all', offset = 0, length = 1, group_id = nil, keyword = nil)
      types = %w(all mine share ismark pause vip recent share_out)
      type = 'all' unless types.include?(type)
      @data = { type: type, offset: offset, length: length }
      @data[:group_id] = group_id unless group_id.nil?
      @data[:keyword] = keyword unless keyword.nil?
    end

    def raw
      info = DNSPod::Post.new('Domain.List', @data).put
      case info
      when '6'
        raise "Invalid offset #{@data[:offset]}"
      when '7'
        raise "Invalid length #{@data[:length]}"
      when '9'
        raise 'No domain found, sorry'
      else
        info
      end
    end

    # get domain id by order
    def self.get_domain_id(n)
      DNSPod::DomainList.new.raw['domains'][n]['id']
    end
  end
end
