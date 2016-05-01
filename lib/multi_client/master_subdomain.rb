module MultiClient
  class MasterSubdomain
    def self.matches?(request)
      case request.subdomain
      when 'master'
        true
      else
        false
      end
    end
  end
end
