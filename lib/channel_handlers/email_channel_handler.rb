class EmailChannelHandler

  include AutoInject["client_adapters.email_client_adapter"]

  def call(template:, subscriber: )
    puts template
    email_client_adapter.(template: template, subscriber: subscriber)
  end


end
