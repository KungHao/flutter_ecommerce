import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  final _firestore = FirebaseFirestore.instance;
  final collection = 'categories';

  void createCategory(String name) {
    String id = Uuid().v1();

    _firestore.collection(collection).doc(id).set({'name': name});
  }

  Future<List<String>> getCategory() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection(collection).get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList = data.docs;
    List<String> categories = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in dataList) {
      String category = snapshot.data()['name'];
      categories.add(category);
    }
    return categories;
  }
}
