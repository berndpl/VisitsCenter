VisitCenter
===========

Location based action triggers

## Usage

1. Add locations to LocationStore

        savedLocations.addObjectsFromArray([
            Location(latitude: 52.543758, longitude: 13.426776, name: "Bio Company, Supermarket"),
            Location(latitude: 52.547569, longitude: 13.419035, name: "Kaisers, Supermarket"),
            Location(latitude: 52.543101, longitude: 13.417494, name: "Bekarei, Café"),
            Location(latitude: 52.545875, longitude: 13.417809, name: "Za Maria, Pizza")
            ])

2. Setup Location Manager (Visits or Geofence based)

        VisitsCenter.shared.setup()
        //GeofenceCenter.shared.setup()