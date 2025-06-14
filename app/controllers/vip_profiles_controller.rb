class VipProfilesController < ApplicationController
  def index
    @vip_profiles = [
      {
        id: 1,
        codename: 'FALCON PRIME',
        tier: 'Presidential',
        preferred_aircraft: 'G650ER-UAE01',
        total_flights: 45,
        last_flight: '2025-05-20',
        special_requirements: ['Security Sweep', 'Medical Team', 'Silent Protocol'],
        status: 'Active'
      },
      {
        id: 2,
        codename: 'EAGLE ONE',
        tier: 'Royal Family',
        preferred_aircraft: 'BBJ-UAE03',
        total_flights: 32,
        last_flight: '2025-05-18',
        special_requirements: ['Presidential Protocol', 'Communication Suite'],
        status: 'Active'
      },
      {
        id: 3,
        codename: 'DESERT STAR',
        tier: 'Government Official',
        preferred_aircraft: 'F7X-UAE02',
        total_flights: 28,
        last_flight: '2025-05-15',
        special_requirements: ['Business Setup', 'Wi-Fi Required'],
        status: 'Active'
      },
      {
        id: 4,
        codename: 'GOLDEN WING',
        tier: 'High-Level Executive',
        preferred_aircraft: 'G550-UAE04',
        total_flights: 19,
        last_flight: '2025-05-12',
        special_requirements: ['Female Security Detail', 'Privacy Screens'],
        status: 'Active'
      },
      {
        id: 5,
        codename: 'SILVER HAWK',
        tier: 'Corporate Executive',
        preferred_aircraft: 'G650ER-UAE01',
        total_flights: 15,
        last_flight: '2025-05-10',
        special_requirements: ['Business Class Service', 'Meeting Setup'],
        status: 'Active'
      }
    ]
  end
  
  def show
    @vip_profile = find_profile(params[:id])
  end
  
  private
  
  def find_profile(id)
    @vip_profiles.find { |profile| profile[:id] == id.to_i }
  end
end
