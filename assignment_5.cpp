// MSCS 632 Assignment 5
// Class Based Ride Sharing System
// Using Encapsulation, Inheritance, and Polymorphism

#include <iostream>
#include <string>
#include <vector>
using namespace std;

// Base Ride class
class Ride {
protected:
    int rideID;
    string pickupLocation;
    string dropoffLocation;
    double distance; // in miles
public:
    Ride(int id, string pickup, string dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist) {}

    virtual double fare() const = 0; // pure virtual method

    virtual void rideDetails() const {
        cout << "Ride ID: " << rideID
             << ", Pickup: " << pickupLocation
             << ", Dropoff: " << dropoffLocation
             << ", Distance: " << distance << " miles"
             << ", Fare: $" << fare() << endl;
    }

    virtual ~Ride() {}
};

// Derived Standard Ride class
class StandardRide : public Ride {
public:
    StandardRide(int id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        return distance * 2.0; // $2 per mile
    }
};

// Derived Premium Ride class
class PremiumRide : public Ride {
public:
    PremiumRide(int id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        return distance * 3.5; // $3.5 per mile
    }
};

// Driver class
class Driver {
private:
    int driverID;
    string name;
    double rating;
    vector<Ride*> assignedRides; // Encapsulated
public:
    Driver(int id, string name, double rating)
        : driverID(id), name(name), rating(rating) {}

    void addRide(Ride* ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        cout << "Driver ID: " << driverID
             << ", Name: " << name
             << ", Rating: " << rating
             << ", Completed Rides: " << assignedRides.size() << endl;
        for (const auto& ride : assignedRides) {
            ride->rideDetails();
        }
    }
};

// Rider class
class Rider {
private:
    int riderID;
    string name;
    vector<Ride*> requestedRides;
public:
    Rider(int id, string name) : riderID(id), name(name) {}

    void requestRide(Ride* ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        cout << "Rider ID: " << riderID
             << ", Name: " << name
             << ", Ride History: " << requestedRides.size() << endl;
        for (const auto& ride : requestedRides) {
            ride->rideDetails();
        }
    }
};

// Main function demonstrating system functionality
int main() {
    // Create some rides
    Ride* ride1 = new StandardRide(101, "Downtown", "Uptown", 5.0);
    Ride* ride2 = new PremiumRide(102, "Airport", "Hotel", 10.0);
    Ride* ride3 = new StandardRide(103, "Mall", "Station", 3.2);

    // Store in a list (polymorphism)
    vector<Ride*> rides = {ride1, ride2, ride3};

    cout << "\n--- Ride Details (Polymorphism) ---\n";
    for (const auto& ride : rides) {
        ride->rideDetails();
    }

    // Create Driver
    Driver driver1(201, "Alice", 4.8);
    driver1.addRide(ride1);
    driver1.addRide(ride2);

    cout << "\n--- Driver Info ---\n";
    driver1.getDriverInfo();

    // Create Rider
    Rider rider1(301, "Bob");
    rider1.requestRide(ride1);
    rider1.requestRide(ride3);

    cout << "\n--- Rider Info ---\n";
    rider1.viewRides();

    // Cleanup
    for (auto& ride : rides) {
        delete ride;
    }

    return 0;
}