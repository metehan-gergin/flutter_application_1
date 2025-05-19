import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (doc.exists) return doc.data();
    } catch (e) {
      print("Veri alınamadı: $e");
    }
    return null;
  }
}
