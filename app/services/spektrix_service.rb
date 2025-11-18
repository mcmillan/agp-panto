class SpektrixService
  include Singleton

  def get_instances
    Rails.cache.fetch("#{client_name}/#{event_id}", expires_in: 1.minute) do
      get("https://system.spektrix.com/#{client_name}/api/v3/events/#{event_id}/instances")
    end
  end

  def get_instance_status(instance_id:)
    Rails.cache.fetch("#{client_name}/#{instance_id}", expires_in: 1.minute) do
      get("https://system.spektrix.com/#{client_name}/api/v3/instances/#{instance_id}/status")
    end
  end

  private def get(...)
    client.get(...).tap(&:raise_for_status).then { JSON.parse(_1) }
  end

  private def event_id = Rails.application.credentials.spektrix.event_id
  private def client_name = Rails.application.credentials.spektrix.client_name

  private def client = HTTPX
end
