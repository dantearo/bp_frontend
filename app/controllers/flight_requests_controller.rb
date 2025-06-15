class FlightRequestsController < ApplicationController
  def index
    @filter_value = params[:filter] || 'all'
    @sort_by = params[:sort] || 'urgent'
    @search_term = params[:search] || ''
    @view_type = params[:view] || 'cards'
    
    # Set up table configuration
    @flight_requests_table_columns = flight_requests_table_columns
    @flight_requests_row_class = flight_requests_row_class
    
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
    @request = find_detailed_request(params[:id])
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
  
  def find_detailed_request(id)
    # Sample detailed request data for the specified ID
    {
      id: id,
      vip_codename: 'FALCON PRIME',
      vip_real_name: 'Sheikh Mohammed Al Maktoum', # Only shown to authorized users
      source_of_request: 'Sarah Al Mansoori',
      organization: 'Royal Court Office',
      status: 'Request Under Process',
      priority: 'Ultra High',
      submitted_at: '2025-05-20T08:30:00Z',
      departure_date: '2025-05-21',
      departure_time: '14:00',
      departure_airport: 'AUH - Abu Dhabi International Airport',
      departure_airport_code: 'AUH',
      arrival_time: '18:30',
      arrival_airport: 'LHR - London Heathrow Airport',
      arrival_airport_code: 'LHR',
      passengers: 4,
      time_to_flight: '18h 30m',
      urgency_level: 'high',
      special_requirements: ['Advance Security Sweep', 'Medical Team Standby', 'Silent Protocol', 'No Photography'],
      notes: 'Royal family member attending state function. Embassy coordination required for security protocols.',
      assigned_to: 'Ahmed Al Rashid',
      last_updated: '2025-05-20T09:15:00Z',
      aircraft_assigned: 'G650ER-UAE01',
      estimated_flight_time: '4h 30m',
      legs: [
        {
          leg: 1,
          departure: 'AUH - Abu Dhabi International',
          arrival: 'LHR - London Heathrow',
          date: '2025-05-21',
          departure_time: '14:00',
          arrival_time: '18:30',
          local_departure_time: '14:00 GST',
          local_arrival_time: '18:30 GMT'
        }
      ],
      timeline: [
        {
          status: 'Request Sent',
          timestamp: '2025-05-20T08:30:00Z',
          user: 'Sarah Al Mansoori',
          action: 'Flight request submitted',
          completed: true
        },
        {
          status: 'Request Received',
          timestamp: '2025-05-20T08:32:00Z',
          user: 'System',
          action: 'Request received and assigned to Ahmed Al Rashid',
          completed: true
        },
        {
          status: 'Request Under Review',
          timestamp: '2025-05-20T08:45:00Z',
          user: 'Ahmed Al Rashid',
          action: 'Security clearance verification initiated',
          completed: true
        },
        {
          status: 'Request Under Process',
          timestamp: '2025-05-20T09:15:00Z',
          user: 'Ahmed Al Rashid',
          action: 'Aircraft and crew assignment in progress',
          completed: false,
          current: true
        },
        {
          status: 'Request Done',
          timestamp: nil,
          user: nil,
          action: 'Flight confirmed and passenger manifest ready',
          completed: false
        }
      ],
      attachments: [
        {
          id: 1,
          name: 'Security_Protocol_Requirements.pdf',
          type: 'pdf',
          size: '245 KB',
          uploaded_by: 'Sarah Al Mansoori',
          uploaded_at: '2025-05-20T08:30:00Z'
        }
      ],
      communications: [
        {
          id: 1,
          timestamp: '2025-05-20T09:20:00Z',
          user: 'Ahmed Al Rashid',
          type: 'note',
          message: 'Coordinating with embassy security team for arrival protocols.'
        },
        {
          id: 2,
          timestamp: '2025-05-20T09:15:00Z',
          user: 'Ahmed Al Rashid',
          type: 'status_change',
          message: 'Status advanced to Under Process. Aircraft G650ER-UAE01 allocated.'
        }
      ]
    }
  end
  
  def flight_requests_table_columns
    [
      {
        key: :id,
        label: 'Request',
        width: 'minmax(120px, 1fr)',
        render: lambda do |request, index|
          <<~HTML.html_safe
            <div>
              <p class="font-medium text-gray-800">#{request[:id]}</p>
              <p class="text-xs text-gray-500">#{request[:source_of_request]}</p>
            </div>
          HTML
        end
      },
      {
        key: :vip_codename,
        label: 'VIP Profile',
        width: 'minmax(120px, 1fr)',
        render: lambda do |request, index|
          <<~HTML.html_safe
            <div>
              <p class="font-medium">#{request[:vip_codename]}</p>
              <p class="text-xs text-gray-500">#{request[:organization]}</p>
            </div>
          HTML
        end
      },
      {
        key: :route,
        label: 'Route',
        width: 'minmax(120px, 1fr)',
        render: lambda do |request, index|
          <<~HTML.html_safe
            <div class="flex items-center text-xs">
              <span>#{request[:departure_airport].split(' - ')[0]}</span>
              <i data-lucide="arrow-right" class="w-3 h-3 mx-1 text-gray-400"></i>
              <span>#{request[:arrival_airport].split(' - ')[0]}</span>
            </div>
          HTML
        end
      },
      {
        key: :departure_date,
        label: 'Departure',
        width: 'minmax(100px, 1fr)',
        render: lambda do |request, index|
          <<~HTML.html_safe
            <div>
              <p class="font-medium">#{request[:departure_date]}</p>
              <p class="text-xs text-gray-500">#{request[:departure_time]}</p>
            </div>
          HTML
        end
      },
      {
        key: :passengers,
        label: 'Passengers',
        width: 'minmax(80px, 100px)',
        render: lambda do |request, index|
          <<~HTML.html_safe
            <div class="flex items-center">
              <i data-lucide="users" class="w-3 h-3 mr-1 text-gray-400"></i>
              <span class="font-medium">#{request[:passengers]}</span>
            </div>
          HTML
        end
      },
      {
        key: :status,
        label: 'Status',
        width: 'minmax(120px, 1fr)',
        render: lambda do |request, index|
          status_class = case request[:status]
                        when 'Request Received' then 'bg-blue-100 text-blue-700 border-blue-200'
                        when 'Request Under Review' then 'bg-yellow-100 text-yellow-700 border-yellow-200'
                        when 'Request Under Process' then 'bg-purple-100 text-purple-700 border-purple-200'
                        when 'Request Done' then 'bg-green-100 text-green-700 border-green-200'
                        else 'bg-gray-100 text-gray-700 border-gray-200'
                        end
          <<~HTML.html_safe
            <span class="px-2 py-1 text-xs font-medium rounded-full border #{status_class}">
              #{request[:status].gsub('Request ', '')}
            </span>
          HTML
        end
      },
      {
        key: :priority,
        label: 'Priority',
        width: 'minmax(100px, 1fr)',
        render: lambda do |request, index|
          priority_class = case request[:priority]
                          when 'Ultra High' then 'bg-red-100 text-red-700'
                          when 'High' then 'bg-orange-100 text-orange-700'
                          when 'Standard' then 'bg-blue-100 text-blue-700'
                          else 'bg-gray-100 text-gray-700'
                          end
          <<~HTML.html_safe
            <span class="px-2 py-1 text-xs font-medium rounded-full #{priority_class}">
              #{request[:priority]}
            </span>
          HTML
        end
      },
      {
        key: :time_to_flight,
        label: 'Time to Flight',
        width: 'minmax(100px, 1fr)',
        render: lambda do |request, index|
          urgency_indicator = if request[:time_to_flight].match?(/(\d+)h/) && request[:time_to_flight].match(/(\d+)h/)[1].to_i < 12
                             '⚡'
                           elsif request[:time_to_flight].match?(/(\d+)h/) && request[:time_to_flight].match(/(\d+)h/)[1].to_i < 24
                             '🔥'
                           else
                             ''
                           end
          "<span class=\"font-medium\">#{request[:time_to_flight]} #{urgency_indicator}</span>".html_safe
        end
      },
      {
        key: :assigned_to,
        label: 'Assigned To',
        width: 'minmax(100px, 1fr)',
        render: lambda do |request, index|
          "<p class=\"text-sm\">#{request[:assigned_to]}</p>".html_safe
        end
      },
      {
        key: :actions,
        label: 'Actions',
        width: 'minmax(100px, 120px)',
        render: lambda do |request, index|
          <<~HTML.html_safe
            <div class="flex items-center space-x-1">
              <a href="/flight_requests/#{request[:id]}" class="p-1 rounded-lg bg-gray-100 text-gray-600 hover:bg-gray-200">
                <i data-lucide="eye" class="w-4 h-4"></i>
              </a>
              <button class="p-1 rounded-lg bg-gray-100 text-gray-600 hover:bg-gray-200">
                <i data-lucide="edit" class="w-4 h-4"></i>
              </button>
              <button class="p-1 rounded-lg bg-gray-100 text-gray-600 hover:bg-gray-200">
                <i data-lucide="arrow-right" class="w-4 h-4"></i>
              </button>
            </div>
          HTML
        end
      }
    ]
  end
  
  def flight_requests_row_class
    lambda do |request, index|
      case request[:urgency_level]
      when 'high' then 'border-l-4 border-l-red-500 bg-red-50'
      when 'medium' then 'border-l-4 border-l-orange-500 bg-orange-50'
      when 'low' then 'border-l-4 border-l-green-500 bg-green-50'
      when 'completed' then 'border-l-4 border-l-gray-500 bg-gray-50'
      else 'border-l-4 border-l-blue-500 bg-blue-50'
      end
    end
  end
  
  private
  
  def filter_requests(requests)
    # Add filtering logic here if needed
    requests
  end
end
