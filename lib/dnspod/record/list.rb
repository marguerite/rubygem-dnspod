module DNSPod
  # List all DNS records for a specific domain_id
  class RecordList
    def initialize(domain_id, offset = 0, length = 1, sub_domain = nil, keyword = nil)
      @data = { domain_id: domain_id, offset: offset, length: length }
      @data[:sub_domain] = sub_domain unless sub_domain.nil?
      @data[:keyword] = keyword unless keyword.nil?
    end

    def raw
      info = DNSPod::Post.new('Record.List', @data).put
      case info
      when '-7'
        raise 'Update needed to set up domains under enterprise accounts'
      when '-8'
        raise 'Update needed to set up user domains registered under one of our agents'
      when '6'
        raise "Invalid Domain ID #{@data[:domain_id]}"
      when '7'
        raise "Invalid offset #{@data[:offset]}"
      when '8'
        raise "Invalid length #{@data[:length]}"
      when '9'
        raise 'You are not the owner of this domain!'
      when '10'
        raise 'No record found, sorry'
      else
        info
      end
    end

    def get_records(domain_id)
      records = raw['records']
      a_records = []
      records.each { |r| a_records << [r['id'], r['line_id'], r['value']] if r['type'] == 'A' }
      a_records
    end
  end
end
