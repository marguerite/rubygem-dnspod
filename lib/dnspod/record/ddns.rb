module DNSPod
  # Dynamically update DNS A record
  class RecordDDNS
    def initialize(domain_id, sub_domain = 'www')
      record_id, line_id, @ip = get_records(domain_id)
      @data = { domain_id: domain_id, record_id: record_id, record_line_id: line_id, sub_domain: sub_domain }
    end

    def set(value)
      return if value == @ip
      @data[:value] = value
      info = DNSPod::Post.new('Record.Ddns', @data).put
      case info
      when '-15'
        raise 'That domain was blocked, sorry'
      when '-7'
        raise 'Update needed to set up domains under enterprise accounts'
      when '-8'
        raise 'Update needed to set up user domains registered under one of our agents'
      when '6'
        raise "Invalid Domain ID #{@data[:domain_id]}"
      when '7'
        raise 'Not the owner of this domain or have no permission to do this'
      when '8'
        raise "Invalid Record ID #{@data[:record_id]}"
      when '21'
        raise 'Domain has been locked'
      when '22'
        raise "Invalid sub_domain #{@data[:sub_domain]}"
      when '23'
        raise "Level of sub_domain is out of limit. eg: Free Plan doesn't support 3rd-class domain"
      when '24'
        raise "Failed to resolve sub_domain. eg: Free Plan doesn't support A record"
      when '25'
        raise 'Round Robin out of limit. eg: Free Plan can only use 2 of that'
      when '26'
        raise "Invalid line_id. eg: Free Plan doesn't support mobile or foreign route"
      else
        info
      end
    end

    private

    def get_records(domain_id)
      records = DNSPod::RecordList.new(domain_id).raw['records']
      a_record = nil
      records.each { |r| a_record = r if r['type'] == 'A' }
      [a_record['id'], a_recoord['line_id'], a_record['value']]
    end
  end
end
