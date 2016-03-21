module MultiClient
  class Subdomain
    def self.matches?(request)
      case request.subdomain
      when *MultiClient::Configuration.no_subdomain_prefixes.call(request)
        false
      else
        true
      end
    end
  end
end
