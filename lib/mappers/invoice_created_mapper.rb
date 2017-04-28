module Mappers

  class InvoiceCreatedMapper < Base

    map from_event: {type: :invoice_created_event, prop: "amount", to_template: "amount"}
    map from_event: {type: :invoice_created_event, prop: "invoice_date", to_template: "invoice_date"}
    map from_event: {type: :invoice_created_event, prop: "total_kwh", to_template: "total_kwh"}
    map from_event: {type: :invoice_created_event, prop: "first_bill", to_template: "first_bill"}
    map from_subscriber: {prop: "name", to_template: "name" }

  end # class

end
