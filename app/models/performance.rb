class Performance
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :string
  attribute :starts_at, :datetime
  attribute :sales_started_at, :datetime

  delegate :available_seats, to: :status
  delegate :capacity, to: :status

  def self.all
    SpektrixService.instance.get_instances(
      client_name: ENV["CLIENT_NAME"],
      event_id: ENV["EVENT_ID"]
    ).map { from_spektrix(_1) }
  end

  def self.from_spektrix(data)
    new(id: data["id"], starts_at: data["startUtc"], sales_started_at: data["startSellingAtWebUtc"])
  end

  def status
    @status ||= PerformanceStatus.from_spektrix(
      SpektrixService.instance.get_instance_status(client_name: ENV["CLIENT_NAME"], instance_id: id)
    )
  end
end
