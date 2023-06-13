import 'package:cloud_firestore/cloud_firestore.dart';

class MedicationRepository {
  static const usersPath = "users";
  static const medicationsPath = "medications";

  final CollectionReference<Map<String, dynamic>> _usersCollection =
  FirebaseFirestore.instance.collection(usersPath);

  Future<void> createMedication(
      String userId, String medicationId, Map<String, dynamic> input) async {
    final DocumentReference<Map<String, dynamic>> medicationRef =
    _usersCollection
        .doc(userId)
        .collection(medicationsPath)
        .doc(medicationId);
    await medicationRef.set(input);
  }

  Future<void> updateMedication(
      String userId, String medicationId, Map<String, dynamic> input) async {
    final DocumentReference<Map<String, dynamic>> medicationRef =
    _usersCollection
        .doc(userId)
        .collection(medicationsPath)
        .doc(medicationId);
    await medicationRef.update(input);
  }

  Future<void> deleteMedication(String userId, String medicationId) async {
    final DocumentReference<Map<String, dynamic>> medicationRef =
    _usersCollection
        .doc(userId)
        .collection(medicationsPath)
        .doc(medicationId);
    await medicationRef.delete();
  }
}
