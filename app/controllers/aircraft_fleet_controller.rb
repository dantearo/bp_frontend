class AircraftFleetController < ApplicationController
  def index
    @aircraft = [
      {
        id: 'G650ER-UAE01',
        model: 'Gulfstream G650ER',
        status: 'Available',
        location: 'AUH - Abu Dhabi International',
        capacity: 14,
        range: '7000 nm',
        next_maintenance: '2025-06-15',
        hours_flown: 1250
      },
      {
        id: 'F7X-UAE02',
        model: 'Dassault Falcon 7X',
        status: 'In Flight',
        location: 'En Route to DXB',
        capacity: 12,
        range: '5950 nm',
        next_maintenance: '2025-07-10',
        hours_flown: 890
      },
      {
        id: 'BBJ-UAE03',
        model: 'Boeing Business Jet',
        status: 'Maintenance',
        location: 'DWC - Al Maktoum International',
        capacity: 25,
        range: '6200 nm',
        next_maintenance: '2025-05-25',
        hours_flown: 2100
      },
      {
        id: 'G550-UAE04',
        model: 'Gulfstream G550',
        status: 'Available',
        location: 'SHJ - Sharjah International',
        capacity: 12,
        range: '6750 nm',
        next_maintenance: '2025-08-01',
        hours_flown: 1850
      }
    ]
  end
end
