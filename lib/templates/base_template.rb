class BaseTemplate

  # Any Template should:
  # + Take in an event value object it understands
  # + Take in a subscriber object that it may require template values for
  # + Determine the template values needed by the client adapter, without understanding the clients template structure
  # + Name the template
  # Becase the actual content is managed in the SaaS platform (e.g. Mandrill), the template does not need to
  # provide content, only template values

  def initialize
  end

  def name
    raise
  end

  def generate
  end

  def template_values
    {}
  end

end
