import 'package:cloud_firestore/cloud_firestore.dart';

class MedicationRepository {
  static const usersPath = "users";
  static const medicationsPath = "medications";

  static int generateId() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch;
  }

  final CollectionReference<Map<String, dynamic>> _usersCollection =
      FirebaseFirestore.instance.collection(usersPath);

  Future<void> createMedication(
      String userId, int medicationId, Map<String, dynamic> input) async {
    final DocumentReference<Map<String, dynamic>> medicationRef =
        _usersCollection
            .doc(userId)
            .collection(medicationsPath)
            .doc(medicationId.toString());
    await medicationRef.set(input);
  }

  Future<List<Map<String, dynamic>>> fetchAllMedications(String userId) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _usersCollection.doc(userId).collection(medicationsPath).get();

    final List<Map<String, dynamic>> medications = [];

    snapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> document) {
      if (document.data() != null) {
        medications.add(document.data()!);
      }
    });

    print("⭐️ medications");
    print(medications);
    print("⭐️ medications");

    return medications;
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
