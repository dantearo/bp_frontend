class SettingsController < ApplicationController
  def index
    @user_settings = {
      name: 'Ahmed Al Rashid',
      role: 'Operations Staff',
      email: 'ahmed.rashid@presidentialflight.ae',
      department: 'Flight Operations',
      access_level: 'operations_staff',
      language: 'en',
      timezone: 'Asia/Dubai',
      notifications: {
        email: true,
        sms: false,
        in_app: true
      }
    }
    
    @system_settings = {
      default_language: 'en',
      supported_languages: ['en', 'ar'],
      default_timezone: 'Asia/Dubai',
      session_timeout: 30,
      max_file_upload_size: '10MB',
      backup_frequency: 'Daily',
      maintenance_window: '02:00 - 04:00 GST'
    }
    
    @security_settings = {
      two_factor_enabled: true,
      password_expiry: 90,
      login_attempts: 5,
      session_encryption: true,
      audit_logging: true,
      ip_restrictions: false
    }
  end
end
