class PerformanceStatus < ApplicationModel
  attribute :available_seats, :integer
  attribute :capacity, :integer

  def self.from_spektrix(data)
    new(available_seats: data["available"], capacity: data["capacity"])
  end
end
