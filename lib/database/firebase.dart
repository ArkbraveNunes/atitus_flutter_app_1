import 'package:firebase_core/firebase_core.dart';

void initializeFirebase() async {
  await Firebase.initializeApp();
}

//TODO - Exemplo de CRUD - Firebase
// FirebaseFirestore.instance.collection('users');
// .add({"name": "Oscara", "password": "coxinhadefrango", "status": true});
// .get()
// .then(
//     (value) => {value.docs.forEach((element) => print(element.data()))})
// .catchError((onError) => print(onError));
