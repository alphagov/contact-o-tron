require 'messenger'

unless Rails.env.test?
  host = Rails.env.production? ? 'support.cluster' : 'localhost'
  uri = URI::Generic.build scheme: 'stomp', host: host, port: 61613
  failover_uri = "failover://(#{Array.new(2, uri).join(',')})" # failover://() must have multiple URIs
  Messenger.transport = Stomp::Client.new failover_uri
end
