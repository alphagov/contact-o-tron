class Messenger
  include Singleton
  cattr_accessor :transport

  def method_missing(*args, &block)
    client.send *args, &block
  end

  def client
    @client ||= Marples::Client.new self.class.transport, 'contactotron', Rails.logger
  end
end
