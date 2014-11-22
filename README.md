VisitCenter
===========

<<<<<<< HEAD
Location based action triggers

## Usage

1. Add locations to LocationStore
=======
A simple app for testing iOS8 location tracking features. Main goal is to test response times and battery impact of using the Visit based API versus old-school Geofencing.

## Usage

1. Add locations in **LocationStore**
>>>>>>> Added locations store

        savedLocations.addObjectsFromArray([
            Location(latitude: 52.543758, longitude: 13.426776, name: "Bio Company, Supermarket"),
            Location(latitude: 52.547569, longitude: 13.419035, name: "Kaisers, Supermarket"),
            Location(latitude: 52.543101, longitude: 13.417494, name: "Bekarei, Café"),
            Location(latitude: 52.545875, longitude: 13.417809, name: "Za Maria, Pizza")
            ])

<<<<<<< HEAD
2. Setup Location Manager (Visits or Geofence based)
=======
2. Setup Location Manager (Visits or Geofence based), e.g. in your Main **ViewController**
>>>>>>> Added locations store

        VisitsCenter.shared.setup()
        //GeofenceCenter.shared.setup()