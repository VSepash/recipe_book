import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  Future Addrecipe(Map<String, dynamic> addRecipe) async {
    return await FirebaseFirestore.instance.collection("Recipe").add(addRecipe);
  }

  Future<Stream<QuerySnapshot>> getallRecipe()async{
    return await FirebaseFirestore.instance.collection("Recipe").snapshots();

  }
  Future<Stream<QuerySnapshot>> getCategoryRecipe(String category)async{
    return await FirebaseFirestore.instance.collection("Recipe").where("Category", isEqualTo: category).snapshots();

  }

  
}