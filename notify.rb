require 'pry'
require 'dry-container'
require 'dry-auto_inject'
require 'dry-struct'
require 'dry-validation'
require 'dry-monads'
require 'erb'
require 'ostruct'


def set_up_container
  container = Dry::Container.new
  container.register("subscriber", -> { Subscriber } )
  container.namespace("event_handlers") do
    register("event_handler", -> { EventHandler.new } )
    register("invoice_created_handler", -> { InvoiceCreatedHandler.new } )
    register("event_handler_factory", -> { EventHandlerFactory.new } )
  end
  container.namespace("values") do
    register("invoice_created_value", -> { InvoiceCreatedValue } )
    register("subscriber_value", -> { SubscriberValue } )
  end
  container.namespace("channel_handlers") do
    register("channel_handler_factory", -> { ChannelHandlerFactory } )
    register("email_channel_handler", -> { EmailChannelHandler.new} )
    register("email_mapper", -> { MandrillMapper.new} )
  end
  container.namespace("templates") do
    register("template_factory", -> { TemplateFactory.new } )
    register("invoice_created_template", -> { InvoiceCreatedTemplate } )
  end
  container.namespace("client_adapters") do
    register("email_client_adapter", -> { MandrillClient.new } )
  end
  container.namespace("mappers") do
    register("mapper_factory", -> { Mappers::MapperFactory.new } )
    register("invoice_created_mapper", -> { Mappers::InvoiceCreatedMapper.new } )
  end
  container.namespace("schemas") do
    register("schema_catalogue", -> { Schemas::SchemaCatalogue } )
  end
  container
end

Container = set_up_container
AutoInject = Dry::AutoInject(Container)

M = Dry::Monads

Dir["#{Dir.pwd}/lib/**/*.rb"].each {|file| require file }

event = {
          kind: "invoice.created",
          party: "/party/1",
          amount: "10.01",
          invoice_date: Date.today.iso8601,
          first_bill: true,
          total_kwh: "300.10"
        }

Container["event_handlers.event_handler"].(event)
