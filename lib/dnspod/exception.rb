module DNSPod
  class Exception
    # Handle common error codes
    def initialize(code)
      case code
      when '-1'
        raise 'Login failed'
      when '-2'
        raise 'API usage out of limit'
      when '-3'
        raise 'Illegal agent (For Agent Only)'
      when '-4'
        raise 'Not registered under this agent (For Agent Only)'
      when '-7'
        raise 'No permission to use this interface'
      when '-8'
        raise 'Temporary blocked due to too many failed logins'
      when '85'
        raise 'Account not signed in from your common location'
      when '-99'
        raise 'This interface was closed temporarily, please try again later'
      when '2'
        raise 'HTTPS POST method allowed only'
      when '3'
        raise 'Unknown error'
      when '6'
        raise 'Invalid User ID (For Agent Only)'
      when '7'
        raise 'This User ID is not registered under this agent (For Agent Only)'
      when '83'
        raise 'This account has been locked, no way to operate'
      when '85'
        raise 'This account enabled location protection, current IP not among allowed range'
      else
        raise "Unimplemented code #{code}"
      end
    end
  end
end
