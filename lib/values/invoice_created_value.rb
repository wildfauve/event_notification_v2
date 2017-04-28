require './lib/types'

class InvoiceCreatedValue < Dry::Struct

  attribute :kind, Types::Symbol
  attribute :party_url, Types::String
  attribute :amount, Types::Float
  attribute :invoice_date, Types::Json::Time
  attribute :first_bill, Types::Bool
  attribute :total_kwh, Types::String

end
