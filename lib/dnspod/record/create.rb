module DNSPod
  # Add a new DNS Record
  class RecordCreate
    def initialize(domain_id, sub_domain = '@', record_type = 'A', line_id = 0, mx = nil, ttl = 10, weight = 0)
      @data = { domain_id: domain_id, sub_domain: sub_domain, record_type: record_type,
                record_line_id: line_id, weight: weight, ttl: ttl }
      @data[:mx] = mx || 20 if record_type == 'MX'
    end

    def set(value)
      @data[:value] = value
      info = DNSPod::Post.new('Record.Create', @data).put
      case info
      when '-15'
        raise 'That domain was blocked, sorry'
      when '-7'
        raise 'Update needed to set up domains under enterprise accounts'
      when '-8'
        raise 'Update needed to set up user domains registered under one of our agents'
      when '6'
        raise 'Missing or invalid parameters'
      when '7'
        raise 'Not the owner of this domain or have no permission to do this'
      when '21'
        raise 'Domain has been locked'
      when '22'
        raise "Illegal sub_domain #{@data[:sub_domain]}"
      when '23'
        raise "Level of sub_domain is out of limit. eg: Free Plan doesn't support 3rd-class domain"
      when '24'
        raise "Failed to resolve sub_domain. eg: Free Plan doesn't support A record"
      when '500025'
        raise 'The load balance for A record is out of limit'
      when '500026'
        raise 'The load balance for CNAME record is out of limit'
      when '26'
        raise "Invalid line_id #{@data[:line_id]}"
      when '27'
        raise "Invalid record_type #{@data[:record_type]}"
      when '30'
        raise 'Invalid MX value {1-20}'
      when '31'
        raise "Conflict records! (A, CNAME, URL records can't co-exist"
      when '32'
        raise "TTL is out of limit #{@data[:ttl]}"
      when '33'
        raise 'AAAA record is out of limit'
      when '34'
        raise 'Illegal record value'
      when '36'
        raise 'The NS record for @ host can only use the default line_id'
      when '82'
        raise 'The IP to add was in our blacklist.'
      else
        info
      end
    end
  end
end
