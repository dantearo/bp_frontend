class DashboardController < ApplicationController
  def index
    # Dashboard metrics
    @metrics = [
      { title: 'Total Requests', value: '23', trend: '+5', color: 'blue', urgent: 3 },
      { title: 'Under Review', value: '8', trend: '+2', color: 'orange', urgent: 2 },
      { title: 'In Process', value: '6', trend: '+1', color: 'purple', urgent: 1 },
      { title: 'Urgent (< 24h)', value: '4', trend: '+2', color: 'red', urgent: 4 }
    ]
    
    # Recent flight requests
    @recent_requests = [
      {
        id: 'FR-001/2025',
        vip_codename: 'FALCON PRIME',
        source_of_request: 'Sarah Al Mansoori',
        status: 'Request Under Review',
        priority: 'Ultra High',
        departure_date: '2025-05-21',
        time_to_flight: '18h 30m',
        urgency_level: 'high'
      },
      {
        id: 'FR-002/2025',
        vip_codename: 'EAGLE ONE',
        source_of_request: 'Ahmed Al Qasimi',
        status: 'Request Under Process',
        priority: 'Ultra High',
        departure_date: '2025-05-22',
        time_to_flight: '2d 1h 30m',
        urgency_level: 'medium'
      }
    ]
  end
end
