class EducationModel {
  final int? id;
  final String driverName;
  final String driverRoute;
  final String driverAge;
  final String vehicleName;

  EducationModel({
    this.id,
    required this.driverName,
    required this.driverRoute,
    required this.driverAge,
    required this.vehicleName,
  });

  // Convert model to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'driver_name': driverName,
      'driver_route': driverRoute,
      'driver_age': driverAge,
      'vehicle_name': vehicleName,
    };
  }

  // Create model from JSON (optional, for fetching data)
  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'],
      driverName: json['driver_name'] ?? '',
      driverRoute: json['driver_route'] ?? '',
      driverAge: json['driver_age'] ?? '',
      vehicleName: json['vehicle_name'] ?? '',
    );
  }
}