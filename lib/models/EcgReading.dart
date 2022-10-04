class EcgReading {
  final String id;
  final String patientId;
  final String leadType;
  final String leadPlacement;
  final String hospitalName;
  final double speed;
  final double limb;
  final double chest;
  final String createdAt;
  final String prediction;

  EcgReading(
      {required this.id,
      required this.patientId,
      required this.leadType,
      required this.leadPlacement,
      required this.hospitalName,
      required this.speed,
      required this.limb,
      required this.chest,
      required this.createdAt,
      required this.prediction});

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patient_id': patientId,
      'lead_type': leadType,
      'lead_placement': leadPlacement,
      'hospital_name': hospitalName,
      'speed': speed,
      'limb': limb,
      'chest': chest,
      'created_at': createdAt,
      'prediction': prediction
    };
  }

  EcgReading.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        patientId = json["patient_id"],
        leadType = json["lead_type"],
        leadPlacement = json["lead_placement"],
        hospitalName = json["hospital_name"],
        speed = json["speed"],
        limb = json["limb"],
        chest = json["chest"],
        prediction = json["prediction"],
        createdAt = json["created_at"];
}
