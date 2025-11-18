class SpektrixService
  include Singleton

  def get_instances(client_name:, event_id:)
    Rails.cache.fetch("#{client_name}/#{event_id}", expires_in: 1.minute) do
      get("https://system.spektrix.com/#{client_name}/api/v3/events/#{event_id}/instances")
    end
  end

  def get_instance_status(client_name:, instance_id:)
    Rails.cache.fetch("#{client_name}/#{instance_id}", expires_in: 1.minute) do
      get("https://system.spektrix.com/#{client_name}/api/v3/instances/#{instance_id}/status")
    end
  end

  private def get(...)
    client.get(...).tap(&:raise_for_status).then { JSON.parse(_1) }
  end

  private def client = HTTPX
end
