class tripsModel {
  int? tripId;
  String? matchedRideIds;
  String? pickupLocation;
  String? dropoffLocation;
  String? tripDate;
  String? tripTime;
  int? seats;
  int? status;
  int? driverId;

  tripsModel(
      {this.tripId,
      this.matchedRideIds,
      this.pickupLocation,
      this.dropoffLocation,
      this.tripDate,
      this.tripTime,
      this.seats,
      this.status,
      this.driverId});

  tripsModel.fromJson(Map<String, dynamic> json) {
    tripId = json['trip_id'];
    matchedRideIds = json['matched_ride_ids'];
    pickupLocation = json['pickup_location'];
    dropoffLocation = json['dropoff_location'];
    tripDate = json['trip_date'];
    tripTime = json['trip_time'];
    seats = json['seats'];
    status = json['status'];
    driverId = json['driver_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_id'] = this.tripId;
    data['matched_ride_ids'] = this.matchedRideIds;
    data['pickup_location'] = this.pickupLocation;
    data['dropoff_location'] = this.dropoffLocation;
    data['trip_date'] = this.tripDate;
    data['trip_time'] = this.tripTime;
    data['seats'] = this.seats;
    data['status'] = this.status;
    data['driver_id'] = this.driverId;
    return data;
  }
}