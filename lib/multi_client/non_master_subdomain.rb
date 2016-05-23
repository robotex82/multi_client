module MultiClient
  class NonMasterSubdomain
    def self.matches?(request)
      case request.subdomain
      when 'master'
        false
      else
        true
      end
    end
  end
end
