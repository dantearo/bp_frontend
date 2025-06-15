class LogsAuditController < ApplicationController
  def index
    @filter_type = params[:filter_type] || 'all'
    @date_range = params[:date_range] || 'today'
    @selected_user = params[:selected_user] || 'all'
    @search_term = params[:search] || ''
    
    # Statistics data
    @statistics = [
      { title: "Today's Events", value: '247', icon: 'activity', color: 'blue' },
      { title: 'Security Alerts', value: '3', icon: 'shield', color: 'red' },
      { title: 'Active Users', value: '12', icon: 'users', color: 'green' },
      { title: 'Data Access Events', value: '8', icon: 'eye', color: 'orange' }
    ]
    
    # Set up table configuration
    @audit_table_columns = audit_table_columns
    @audit_expand_content = audit_expand_content
    
    # Sample audit logs data
    @audit_logs = [
      {
        id: 'LOG-20250520-001',
        timestamp: '2025-05-20T14:30:15.234Z',
        event_type: 'REQUEST_STATUS_CHANGE',
        category: 'Request Management',
        user: 'Ahmed Al Rashid',
        user_role: 'Operations Staff',
        ip_address: '10.1.1.45',
        user_agent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        action: 'Status Advanced',
        resource: 'Flight Request FR-001/2025',
        resource_type: 'FlightRequest',
        resource_id: 'FR-001/2025',
        details: {
          previous_status: 'Request Under Review',
          new_status: 'Request Under Process',
          vip_codename: 'FALCON PRIME',
          reason: 'Security clearance verified, proceeding with aircraft assignment'
        },
        success: true,
        severity: 'INFO',
        session_id: 'sess_abc123def456',
        location: 'Abu Dhabi, UAE'
      },
      {
        id: 'LOG-20250520-002',
        timestamp: '2025-05-20T14:15:42.567Z',
        event_type: 'VIP_PROFILE_ACCESS',
        category: 'Data Access',
        user: 'Fatima Al Zahra',
        user_role: 'Operations Admin',
        ip_address: '10.1.1.67',
        user_agent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        action: 'Real Identity Viewed',
        resource: 'VIP Profile EAGLE ONE',
        resource_type: 'VipProfile',
        resource_id: 'VIP-0002',
        details: {
          vip_codename: 'EAGLE ONE',
          real_name: '[CLASSIFIED]',
          access_reason: 'Preparing diplomatic security briefing',
          authorization_level: 'Operations Admin',
          data_fields_accessed: ['Real Name', 'Security Clearance', 'Contact Information']
        },
        success: true,
        severity: 'HIGH',
        session_id: 'sess_xyz789abc123',
        location: 'Abu Dhabi, UAE'
      },
      {
        id: 'LOG-20250520-003',
        timestamp: '2025-05-20T13:45:18.891Z',
        event_type: 'AUTHENTICATION_FAILURE',
        category: 'Security',
        user: 'unknown@external.com',
        user_role: 'None',
        ip_address: '203.45.67.89',
        user_agent: 'Mozilla/5.0 (Linux; Android 10)',
        action: 'Failed Login Attempt',
        resource: 'Authentication System',
        resource_type: 'System',
        resource_id: nil,
        details: {
          attempted_email: 'unknown@external.com',
          failure_reason: 'Invalid credentials',
          consecutive_failures: 3,
          account_locked: false,
          uae_pass_attempt: false,
          suspicious_activity: true
        },
        success: false,
        severity: 'CRITICAL',
        session_id: nil,
        location: 'External'
      },
      {
        id: 'LOG-20250520-004',
        timestamp: '2025-05-20T13:20:05.123Z',
        event_type: 'USER_CREATED',
        category: 'User Management',
        user: 'Omar Al Mazrouei',
        user_role: 'Operations Admin',
        ip_address: '10.1.1.23',
        user_agent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        action: 'Source of Request Created',
        resource: 'User Account: Layla Al Nuaimi',
        resource_type: 'User',
        resource_id: 'SOR-0007',
        details: {
          new_user_name: 'Layla Al Nuaimi',
          user_type: 'Source of Request',
          organization: 'Dubai Holdings',
          access_level: 'Basic',
          vip_relationships: ['VIP-0005'],
          uae_pass_linked: true,
          email_sent: true
        },
        success: true,
        severity: 'MEDIUM',
        session_id: 'sess_def456ghi789',
        location: 'Abu Dhabi, UAE'
      },
      {
        id: 'LOG-20250520-005',
        timestamp: '2025-05-20T12:30:33.445Z',
        event_type: 'REQUEST_CREATED',
        category: 'Request Management',
        user: 'Sarah Al Mansoori',
        user_role: 'Source of Request',
        ip_address: '10.1.2.45',
        user_agent: 'Presidential Flight Mobile App 1.0.0 (iOS)',
        action: 'Flight Request Submitted',
        resource: 'Flight Request FR-003/2025',
        resource_type: 'FlightRequest',
        resource_id: 'FR-003/2025',
        details: {
          vip_codename: 'GOLDEN WING',
          route: 'AUH → DXB',
          departure_date: '2025-05-22',
          passengers: 3,
          priority: 'High',
          special_requirements: ['Female Security Detail', 'Privacy Screens'],
          submission_method: 'Mobile App'
        },
        success: true,
        severity: 'INFO',
        session_id: 'mobile_sess_789abc',
        location: 'Abu Dhabi, UAE'
      },
      {
        id: 'LOG-20250520-006',
        timestamp: '2025-05-20T11:45:22.678Z',
        event_type: 'SYSTEM_BACKUP',
        category: 'System Maintenance',
        user: 'System',
        user_role: 'System',
        ip_address: '10.1.1.1',
        user_agent: 'Automated Backup Service',
        action: 'Database Backup Completed',
        resource: 'Database',
        resource_type: 'System',
        resource_id: 'DB_BACKUP_20250520',
        details: {
          backup_size: '2.4 GB',
          backup_duration: '12 minutes',
          tables_backed_up: 15,
          records_backed_up: 45230,
          backup_location: '/secure/backups/20250520/',
          encryption_status: 'Encrypted with AES-256',
          verification_status: 'Verified'
        },
        success: true,
        severity: 'INFO',
        session_id: 'system_automated',
        location: 'Data Center'
      },
      {
        id: 'LOG-20250520-007',
        timestamp: '2025-05-20T10:15:11.234Z',
        event_type: 'CONFIGURATION_CHANGE',
        category: 'System Configuration',
        user: 'Ahmed Al Rashid',
        user_role: 'Operations Staff',
        ip_address: '10.1.1.45',
        user_agent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        action: 'Alert Threshold Modified',
        resource: 'System Configuration',
        resource_type: 'Configuration',
        resource_id: 'ALERT_CONFIG_001',
        details: {
          config_parameter: 'Flight Alert Timing',
          previous_value: '24, 12, 6 hours',
          new_value: '72, 48, 24, 12, 6 hours',
          reason: 'Enhanced monitoring for VIP flights',
          approved_by: 'Fatima Al Zahra'
        },
        success: true,
        severity: 'MEDIUM',
        session_id: 'sess_abc123def456',
        location: 'Abu Dhabi, UAE'
      }
    ]
    
    # Filter logs based on current selections
    @filtered_logs = filter_logs(@audit_logs)
  end
  
  def audit_table_columns
    [
      {
        key: :timestamp,
        label: 'Timestamp',
        type: :datetime,
        width: 'minmax(120px, 1fr)',
        class: 'flex items-center'
      },
      {
        key: :action,
        label: 'Event', 
        width: 'minmax(150px, 2fr)',
        render: lambda do |log, index|
          event_color = case log[:event_type]
                       when 'AUTHENTICATION_FAILURE' then 'text-red-600'
                       when 'VIP_PROFILE_ACCESS' then 'text-orange-600' 
                       when 'REQUEST_STATUS_CHANGE' then 'text-blue-600'
                       when 'USER_CREATED' then 'text-green-600'
                       when 'CONFIGURATION_CHANGE' then 'text-purple-600'
                       else 'text-gray-600'
                       end
          <<~HTML.html_safe
            <div>
              <p class="font-medium #{event_color}">#{log[:action]}</p>
              <p class="text-xs text-gray-500">#{log[:event_type]}</p>
            </div>
          HTML
        end
      },
      {
        key: :category,
        label: 'Category',
        width: 'minmax(120px, 1fr)',
        render: lambda do |log, index|
          icon = case log[:category]
                 when 'Request Management' then 'calendar'
                 when 'Data Access' then 'eye'
                 when 'Security' then 'shield'
                 when 'User Management' then 'users'
                 when 'System Maintenance' then 'database'
                 when 'System Configuration' then 'settings'
                 else 'activity'
                 end
          <<~HTML.html_safe
            <div class="flex items-center">
              <i data-lucide="#{icon}" class="w-4 h-4 mr-2"></i>
              <span class="text-sm">#{log[:category]}</span>
            </div>
          HTML
        end
      },
      {
        key: :user,
        label: 'User',
        width: 'minmax(100px, 1fr)',
        render: lambda do |log, index|
          <<~HTML.html_safe
            <div>
              <p class="font-medium text-gray-800">#{log[:user]}</p>
              <p class="text-xs text-gray-500">#{log[:user_role]}</p>
            </div>
          HTML
        end
      },
      {
        key: :resource,
        label: 'Resource',
        width: 'minmax(150px, 2fr)',
        render: lambda do |log, index|
          <<~HTML.html_safe
            <div>
              <p class="font-medium text-gray-800 truncate">#{log[:resource]}</p>
              <p class="text-xs text-gray-500">#{log[:resource_type]}</p>
            </div>
          HTML
        end
      },
      {
        key: :ip_address,
        label: 'IP Address',
        width: 'minmax(100px, 1fr)',
        render: lambda do |log, index|
          "<p class=\"font-mono text-xs\">#{log[:ip_address]}</p>".html_safe
        end
      },
      {
        key: :location,
        label: 'Location',
        width: 'minmax(80px, 1fr)',
        render: lambda do |log, index|
          "<p class=\"text-sm\">#{log[:location]}</p>".html_safe
        end
      },
      {
        key: :success,
        label: 'Status',
        width: 'minmax(60px, 80px)',
        type: :boolean
      },
      {
        key: :severity,
        label: 'Severity',
        width: 'minmax(80px, 100px)',
        render: lambda do |log, index|
          badge_class = case log[:severity]
                       when 'CRITICAL' then 'bg-red-100 text-red-700 border-red-200'
                       when 'HIGH' then 'bg-orange-100 text-orange-700 border-orange-200'
                       when 'MEDIUM' then 'bg-yellow-100 text-yellow-700 border-yellow-200'
                       when 'INFO' then 'bg-blue-100 text-blue-700 border-blue-200'
                       else 'bg-gray-100 text-gray-700 border-gray-200'
                       end
          <<~HTML.html_safe
            <span class="px-2 py-1 text-xs font-medium rounded-full border #{badge_class}">
              #{log[:severity]}
            </span>
          HTML
        end
      },
      {
        key: :actions,
        label: 'Actions',
        width: 'minmax(80px, 100px)',
        render: lambda do |log, index|
          <<~HTML.html_safe
            <div class="flex items-center space-x-1">
              <button class="p-1 rounded-lg bg-gray-100 text-gray-600 hover:bg-gray-200">
                <i data-lucide="eye" class="w-4 h-4"></i>
              </button>
              <button class="p-1 rounded-lg bg-gray-100 text-gray-600 hover:bg-gray-200">
                <i data-lucide="external-link" class="w-4 h-4"></i>
              </button>
            </div>
          HTML
        end
      }
    ]
  end
  
  def audit_expand_content
    lambda do |log, index|
      <<~HTML.html_safe
        <div class="grid grid-cols-2 gap-6 pt-4">
          <div>
            <h4 class="font-semibold text-gray-800 mb-3">Event Details</h4>
            <div class="space-y-2">
              <div class="grid grid-cols-2 gap-2">
                <span class="text-xs text-gray-500">Log ID:</span>
                <span class="text-xs font-mono">#{log[:id]}</span>
              </div>
              <div class="grid grid-cols-2 gap-2">
                <span class="text-xs text-gray-500">Session ID:</span>
                <span class="text-xs font-mono">#{log[:session_id] || 'N/A'}</span>
              </div>
              <div class="grid grid-cols-2 gap-2">
                <span class="text-xs text-gray-500">User Agent:</span>
                <span class="text-xs truncate" title="#{log[:user_agent]}">#{log[:user_agent]}</span>
              </div>
              <div class="grid grid-cols-2 gap-2">
                <span class="text-xs text-gray-500">Resource ID:</span>
                <span class="text-xs">#{log[:resource_id] || 'N/A'}</span>
              </div>
            </div>
          </div>
          <div>
            <h4 class="font-semibold text-gray-800 mb-3">Additional Information</h4>
            <div class="bg-white rounded-lg p-3">
              <pre class="text-xs text-gray-700 whitespace-pre-wrap">#{JSON.pretty_generate(log[:details])}</pre>
            </div>
          </div>
        </div>
      HTML
    end
  end
  
  private
  
  def filter_logs(logs)
    filtered = logs
    
    # Apply search filter
    if @search_term.present?
      filtered = filtered.select do |log|
        log[:user].downcase.include?(@search_term.downcase) ||
        log[:action].downcase.include?(@search_term.downcase) ||
        log[:resource].downcase.include?(@search_term.downcase) ||
        log[:id].downcase.include?(@search_term.downcase)
      end
    end
    
    # Apply category filter
    if @filter_type != 'all'
      filtered = filtered.select do |log|
        log[:category].downcase.tr(' ', '_') == @filter_type
      end
    end
    
    # Apply user filter
    if @selected_user != 'all'
      filtered = filtered.select do |log|
        log[:user] == @selected_user
      end
    end
    
    filtered
  end
end
