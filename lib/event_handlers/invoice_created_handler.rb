require_relative "../schemas/schema_catalogue"

class InvoiceCreatedHandler

  include AutoInject["channel_handlers.channel_handler_factory",
                     "values.invoice_created_value",
                     "templates.template_factory",
                     "schemas.schema_catalogue",
                     "mappers.mapper_factory"
                    ]

  INVOICE_SUBJECT = :invoice

  EVENT = "invoice_created_event"

  Container.resolve("schemas.schema_catalogue").add(name: EVENT,
                                                   schema: EVENT_VALIDATION_SCHEMA = Dry::Validation.Schema do
                                                          required(:kind) { filled? }
                                                          required(:party) { filled? }
                                                          required(:amount) { filled? }
                                                          required(:invoice_date).value(type?: String)
                                                          required(:total_kwh) { filled? }
                                                          required(:first_bill) { filled? }
                                                        end
                                                    )


  def call(event, subscriber)
    puts "===>InvoiceCreatedHandler#call"
    chans = channels(subscriber)
    validated_event = event_value(event)
    binding.pry
    if chans.some?
      channel_handler_factory.new.(chans.value)
                             .map {|handler| handler.(subscriber: subscriber,
                                                      template: template_factory.(validated_event)
                                                                                .new(mapper_factory.(validated_event).(validated_event, subscriber))
                                                                                .()
                                                     )
                             }
    end
  end

  private

  def channels(sub)
    # play with Dry Monads
    s  = -> (x) { M.Maybe(x[INVOICE_SUBJECT]) }
    M.Maybe(sub[:subjects]).bind(s)  # This really protects against nil subjects
  end

  def event_value(event)
    validated_event = validate(event)
    @event_value ||= invoice_created_value.new(
                            kind: validated_event[:kind],
                            party_url: validated_event[:party_url],
                            amount: validated_event[:amount],
                            invoice_date: validated_event[:invoice_date],
                            total_kwh: validated_event[:total_kwh],
                            first_bill: validated_event[:first_bill]
                          )
  end

  def validate(event)
    binding.pry
    parse = schema_catalogue.(EVENT).(event)
    raise if parse.failure?
    parse.output
  end


end
