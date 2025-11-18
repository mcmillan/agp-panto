class PerformanceSerializer < ApplicationSerializer
  attributes :starts_at, :sales_started_at, :available_seats, :capacity

  attribute :percentage_sold do |perf|
    (perf.capacity - perf.available_seats).to_f / perf.capacity * 100
  end
end
