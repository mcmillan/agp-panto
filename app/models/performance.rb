class Performance
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :string
  attribute :starts_at, :datetime

  def self.all
    SpektrixService.instance.get_instances(
      client_name:,
      event_id:
    ).map { from_spektrix(_1) }
  end

  def self.from_spektrix(data)
    new(id: data["id"], starts_at: data["startUtc"])
  end

  def status
    @status ||= PerformanceStatus.from_spektrix(
      SpektrixService.instance.get_instance_status(client_name:, instance_id: id)
    )
  end

  private def client_name = ENV["CLIENT_NAME"]
  private def event_id = ENV["EVENT_ID"]
end
