class Medications {
  int? clientMedicationId;
  int? quantity;
  String? description;

  Medications({this.clientMedicationId, this.quantity, this.description});

  Medications.fromJson(Map<String, dynamic> json) {
    clientMedicationId = json['clientMedicationId'];
    quantity = json['quantity'] ?? '';
    description = json['description'];
  }
}
