class PatientModel {
  final int id;
  final String fullName;
  final String address;
  final String phoneNumber;
  final String? remarks;

  PatientModel({
    required this.id,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    this.remarks,
  });

  // Optionally, you can include a method to convert a map to PatientModel
  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] as int,
      fullName: map['full_name'] as String,
      address: map['address'] as String,
      phoneNumber: map['phone_number'] as String,
      remarks: map['remarks'] as String?,
    );
  }

  // You can also include a method to convert PatientModel to a map, useful for inserting/updating records
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'address': address,
      'phone_number': phoneNumber,
      'remarks': remarks,
    };
  }
}
