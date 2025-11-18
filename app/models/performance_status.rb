class PerformanceStatus
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :available, :integer
  attribute :capacity, :integer

  def self.from_spektrix(data)
    new(available: data["available"], capacity: data["capacity"])
  end
end
