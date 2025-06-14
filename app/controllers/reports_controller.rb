class ReportsController < ApplicationController
  def index
    @monthly_stats = {
      total_flights: 78,
      completed_flights: 71,
      cancelled_flights: 7,
      on_time_performance: 94.2,
      average_passengers: 4.2,
      most_used_aircraft: 'G650ER-UAE01'
    }
    
    @route_analytics = [
      { route: 'AUH → DXB', flights: 15, percentage: 19.2 },
      { route: 'AUH → LHR', flights: 12, percentage: 15.4 },
      { route: 'DXB → CDG', flights: 9, percentage: 11.5 },
      { route: 'AUH → DOH', flights: 8, percentage: 10.3 },
      { route: 'SHJ → DXB', flights: 6, percentage: 7.7 }
    ]
    
    @vip_tier_usage = [
      { tier: 'Presidential', flights: 28, percentage: 35.9 },
      { tier: 'Royal Family', flights: 22, percentage: 28.2 },
      { tier: 'Government Official', flights: 18, percentage: 23.1 },
      { tier: 'Corporate Executive', flights: 10, percentage: 12.8 }
    ]
    
    @recent_reports = [
      {
        name: 'May 2025 Flight Operations Report',
        type: 'Monthly Operations',
        generated_at: '2025-05-20T10:00:00Z',
        status: 'Completed'
      },
      {
        name: 'VIP Profile Usage Analysis',
        type: 'Analytics',
        generated_at: '2025-05-19T15:30:00Z',
        status: 'Completed'
      },
      {
        name: 'Aircraft Utilization Report',
        type: 'Fleet Management',
        generated_at: '2025-05-18T09:00:00Z',
        status: 'Completed'
      }
    ]
  end
end
