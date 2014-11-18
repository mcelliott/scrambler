class BasePresenter
  def initialize(object)
    @object = object
  end

  def method_missing(method_name, *args, &block)
    @object.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    @object.respond_to?(method_name, include_private) || super
  end
end
