class LogsAuditController < ApplicationController
  def index
    @filter_type = params[:filter_type] || 'all'
    @date_range = params[:date_range] || 'today'
    @selected_user = params[:selected_user] || 'all'
    @search_term = params[:search] || ''
    
    # Statistics data
    @statistics = {
      todays_events: 247,
      security_alerts: 3,
      active_users: 12,
      data_access_events: 8
    }
    
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
