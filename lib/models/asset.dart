class Asset {
  final String id;
  final String name;
  final String? locationId;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;

  Asset({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
    );
  }
}
