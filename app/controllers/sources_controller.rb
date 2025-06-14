class SourcesController < ApplicationController
  def index
    @sources = [
      {
        id: 1,
        name: 'Sarah Al Mansoori',
        organization: 'Royal Court Office',
        role: 'Chief of Staff',
        access_level: 'Presidential',
        active_requests: 3,
        total_requests: 24,
        contact_method: 'Secure Line',
        last_request: '2025-05-20'
      },
      {
        id: 2,
        name: 'Ahmed Al Qasimi',
        organization: 'Ministry of Interior',
        role: 'Deputy Minister',
        access_level: 'Government',
        active_requests: 2,
        total_requests: 18,
        contact_method: 'Official Email',
        last_request: '2025-05-20'
      },
      {
        id: 3,
        name: 'Khalid Al Hosani',
        organization: 'Sharjah Investment Group',
        role: 'Executive Director',
        access_level: 'Corporate',
        active_requests: 1,
        total_requests: 12,
        contact_method: 'Direct Phone',
        last_request: '2025-05-20'
      },
      {
        id: 4,
        name: 'Fatima Al Mazrouei',
        organization: 'Presidential Affairs',
        role: 'Protocol Officer',
        access_level: 'Presidential',
        active_requests: 0,
        total_requests: 31,
        contact_method: 'Secure Line',
        last_request: '2025-05-19'
      },
      {
        id: 5,
        name: 'Omar Al Ameri',
        organization: 'First Abu Dhabi Bank',
        role: 'CEO',
        access_level: 'Corporate',
        active_requests: 1,
        total_requests: 8,
        contact_method: 'Corporate Email',
        last_request: '2025-05-20'
      }
    ]
  end
end
