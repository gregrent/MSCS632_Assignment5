"MSCS 632 Assignment 5"
"Class Based Ride Sharing System"
"Using Encapsulation, Inheritance and Polymorphism"


"---------------- RIDE CLASS ----------------"
Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

Ride >> initializeWithID: anID pickup: pickup dropoff: drop dist: dist
    rideID := anID.
    pickupLocation := pickup.
    dropoffLocation := drop.
    distance := dist.

Ride >> rideID
    ^ rideID

Ride >> pickupLocation
    ^ pickupLocation

Ride >> dropoffLocation
    ^ dropoffLocation

Ride >> distance
    ^ distance

Ride >> fare
    self subclassResponsibility

Ride >> rideDetails
    ^ 'Ride ID: ', rideID printString,
       ', From: ', pickupLocation,
       ', To: ', dropoffLocation,
       ', Distance: ', distance printString,
       ', Fare: $', self fare printString.

"---------------- RIDE SUBCLASSES ----------------"
Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

StandardRide >> fare
    ^ distance * 2.0.  "Standard rate"


Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

PremiumRide >> fare
    ^ distance * 3.5.  "Premium rate"



"---------------- DRIVER CLASS ----------------"
Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

Driver >> initializeWithID: anID name: aName rating: aRating
    driverID := anID.
    name := aName.
    rating := aRating.
    assignedRides := OrderedCollection new.

Driver >> addRide: aRide
    assignedRides add: aRide.

Driver >> getDriverInfo
    ^ 'Driver ID: ', driverID printString,
       ', Name: ', name,
       ', Rating: ', rating printString,
       ', Total Rides: ', assignedRides size printString.

Driver >> assignedRides
    ^ assignedRides copy. "Encapsulation: Return a copy to prevent direct modification"



"---------------- RIDER CLASS ----------------"
Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

Rider >> initializeWithID: anID name: aName
    riderID := anID.
    name := aName.
    requestedRides := OrderedCollection new.

Rider >> requestRide: aRide
    requestedRides add: aRide.

Rider >> viewRides
    ^ requestedRides collect: [:r | r rideDetails].



"---------------- TEST SCRIPT ----------------"
| ride1 ride2 rides driver rider |

"Create some rides"
ride1 := StandardRide new.
ride1 initializeWithID: 1001 pickup: 'Park' dropoff: 'Mall' dist: 10.

ride2 := PremiumRide new.
ride2 initializeWithID: 1002 pickup: 'Airport' dropoff: 'Hotel' dist: 8.

rides := {ride1. ride2}.

"Polymorphism in action"
rides do: [:r | Transcript show: r rideDetails; cr].

"Create a driver"
driver := Driver new.
driver initializeWithID: 1 name: 'Alice' rating: 4.9.
driver addRide: ride1.
driver addRide: ride2.
Transcript show: driver getDriverInfo; cr.

"Create a rider"
rider := Rider new.
rider initializeWithID: 2001 name: 'Bob'.

"Request rides"
rider requestRide: ride1.
rider requestRide: ride2.

"View ride history"
rider viewRides do: [:info | Transcript show: info; cr].