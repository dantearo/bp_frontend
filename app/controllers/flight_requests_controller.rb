class FlightRequestsController < ApplicationController
  def index
    @filter_value = params[:filter] || 'all'
    @sort_by = params[:sort] || 'urgent'
    @search_term = params[:search] || ''
    @view_type = params[:view] || 'cards'
    
    # Sample data for metrics
    @metrics = [
      { title: 'Total Requests', value: '23', trend: '+5', color: 'blue', urgent: 3 },
      { title: 'Under Review', value: '8', trend: '+2', color: 'orange', urgent: 2 },
      { title: 'In Process', value: '6', trend: '+1', color: 'purple', urgent: 1 },
      { title: 'Urgent (< 24h)', value: '4', trend: '+2', color: 'red', urgent: 4 }
    ]
    
    # Sample flight requests data
    @flight_requests = [
      {
        id: 'FR-001/2025',
        vip_codename: 'FALCON PRIME',
        source_of_request: 'Sarah Al Mansoori',
        organization: 'Royal Court Office',
        status: 'Request Under Review',
        priority: 'Ultra High',
        submitted_at: '2025-05-20T08:30:00Z',
        departure_date: '2025-05-21',
        departure_time: '14:00',
        departure_airport: 'AUH - Abu Dhabi International',
        arrival_time: '18:30',
        arrival_airport: 'LHR - London Heathrow',
        passengers: 4,
        time_to_flight: '18h 30m',
        urgency_level: 'high',
        special_requirements: ['Security Sweep', 'Medical Team', 'Silent Protocol'],
        notes: 'Royal family member attending state function',
        assigned_to: 'Ahmed Al Rashid',
        last_updated: '2025-05-20T09:15:00Z'
      },
      {
        id: 'FR-002/2025',
        vip_codename: 'EAGLE ONE',
        source_of_request: 'Ahmed Al Qasimi',
        organization: 'Ministry of Interior',
        status: 'Request Under Process',
        priority: 'Ultra High',
        submitted_at: '2025-05-20T07:00:00Z',
        departure_date: '2025-05-22',
        departure_time: '10:00',
        departure_airport: 'AUH - Abu Dhabi International',
        arrival_time: '14:30',
        arrival_airport: 'CDG - Charles de Gaulle Paris',
        passengers: 8,
        time_to_flight: '2d 1h 30m',
        urgency_level: 'medium',
        special_requirements: ['Presidential Protocol', 'Communication Suite'],
        notes: 'Official state visit - coordination with embassy required',
        assigned_to: 'Fatima Al Zahra',
        last_updated: '2025-05-20T08:45:00Z',
        aircraft_assigned: 'G650ER-UAE01'
      },
      {
        id: 'FR-003/2025',
        vip_codename: 'DESERT STAR',
        source_of_request: 'Khalid Al Hosani',
        organization: 'Sharjah Investment Group',
        status: 'Request Received',
        priority: 'High',
        submitted_at: '2025-05-20T10:15:00Z',
        departure_date: '2025-05-20',
        departure_time: '20:00',
        departure_airport: 'SHJ - Sharjah International',
        arrival_time: '23:45',
        arrival_airport: 'DXB - Dubai International',
        passengers: 2,
        time_to_flight: '9h 45m',
        urgency_level: 'high',
        special_requirements: ['Business Setup', 'Wi-Fi Required'],
        notes: 'Urgent business meeting - same day travel',
        assigned_to: 'Omar Al Mazrouei',
        last_updated: '2025-05-20T10:15:00Z'
      },
      {
        id: 'FR-004/2025',
        vip_codename: 'GOLDEN WING',
        source_of_request: 'Fatima Al Mazrouei',
        organization: 'Presidential Affairs',
        status: 'Request Done',
        priority: 'High',
        submitted_at: '2025-05-19T14:20:00Z',
        departure_date: '2025-05-19',
        departure_time: '16:00',
        departure_airport: 'AUH - Abu Dhabi International',
        arrival_time: '18:00',
        arrival_airport: 'DWC - Al Maktoum International',
        passengers: 3,
        time_to_flight: 'Completed',
        urgency_level: 'completed',
        special_requirements: ['Female Security Detail', 'Privacy Screens'],
        notes: 'Private family visit - completed successfully',
        assigned_to: 'Layla Al Ameri',
        last_updated: '2025-05-19T19:30:00Z',
        aircraft_assigned: 'F7X-UAE02',
        flight_brief: 'uploaded',
        passenger_list: 'confirmed'
      },
      {
        id: 'FR-005/2025',
        vip_codename: 'SILVER HAWK',
        source_of_request: 'Omar Al Ameri',
        organization: 'First Abu Dhabi Bank',
        status: 'Request Under Review',
        priority: 'Standard',
        submitted_at: '2025-05-20T09:45:00Z',
        departure_date: '2025-05-25',
        departure_time: '12:00',
        departure_airport: 'AUH - Abu Dhabi International',
        arrival_time: '16:30',
        arrival_airport: 'DOH - Hamad International',
        passengers: 5,
        time_to_flight: '5d 2h 15m',
        urgency_level: 'low',
        special_requirements: ['Business Class Service', 'Meeting Setup'],
        notes: 'Regional business conference',
        assigned_to: 'Ahmed Al Rashid',
        last_updated: '2025-05-20T10:00:00Z'
      }
    ]
    
    # Filter requests based on search and filter
    @filtered_requests = filter_requests(@flight_requests)
  end
  
  def show
    @request = find_request(params[:id])
  end
  
  private
  
  def filter_requests(requests)
    filtered = requests
    
    # Apply search filter
    if @search_term.present?
      filtered = filtered.select do |request|
        request[:vip_codename].downcase.include?(@search_term.downcase) ||
        request[:source_of_request].downcase.include?(@search_term.downcase) ||
        request[:id].downcase.include?(@search_term.downcase) ||
        request[:departure_airport].downcase.include?(@search_term.downcase) ||
        request[:arrival_airport].downcase.include?(@search_term.downcase)
      end
    end
    
    # Apply status filter
    if @filter_value != 'all'
      filtered = filtered.select do |request|
        request[:status].downcase.tr(' ', '_') == @filter_value.downcase
      end
    end
    
    filtered
  end
  
  def find_request(id)
    # This would normally query the database
    @flight_requests.find { |request| request[:id] == id }
  end
end
