class ChannelHandlerFactory

  def call(channels)
    channels.map {|channel| channel_slug(channel) }
                .map {|slug| Container.resolve(slug) rescue nil}
                .delete_if {|handler| handler.nil?}
  end

  def channel_slug(channel)
    "channel_handlers.#{channel}_channel_handler"
  end



end
