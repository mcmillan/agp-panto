class ApplicationModel
  include ActiveModel::Model
  include ActiveModel::Attributes

  def as_json(...)
    raise "Direct JSON serialization is not supported, use a serializer instead"
  end
end
