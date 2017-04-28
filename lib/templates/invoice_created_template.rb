class InvoiceCreatedTemplate < BaseTemplate

  AutoInject['mappers.invoice_created_mapper']

  attr_reader :event, :subscriber, :mapper_value, :message

  def initialize(mapper_value)
    @mapper_value = mapper_value
  end

  def call
    @message = template()
  end

  def template
    erb = ERB.new(File.open("#{__dir__}/views/invoice_created_notification.html.erb").read, 0, '>')
    erb.result binding
  end


  private

  # general_variables:
  #   week_bill
  #   fname
  #   bill_to_pay
  #   update_profile
  #   unsub
  #   invoice_has_estimates
  #
  #
  # conditionals:
  #   first_bill
  #   multi_bills




end
