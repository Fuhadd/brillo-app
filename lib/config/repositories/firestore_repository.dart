import 'package:brilloapp/config/Helpers/constants.dart';
import 'package:brilloapp/models/models.dart' as app_user;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreRepository {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('UserData');

  Future<void> saveUserCredentials(
    String userName,
    String email,
    String phone,
    String? gender,
    //List<String> interests,
    // String imageUrl,
  ) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(

        //document().set(
        {
          'email': email,
          'userName': userName,
          'phone': phone,
          'gender': gender,
          //'interests': interests,
          //'imageUrl': imageUrl,
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  // Future<void> saveUserImage(
  //   String imageUrl,
  // ) async {
  //   String? uid = firebaseAuth.currentUser?.uid.toString();
  //   await firebaseFirestore.doc(uid.toString()).set(
  //       {
  //         'imageUrl': imageUrl,
  //       },
  //       SetOptions(
  //         merge: true,
  //       ));
  //   return;
  // }

  Future<void> saveInterests(
    List<String> interests,
  ) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(
        {
          'interests': interests,
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  Future<void> saveImage(
    String imageUrl,
  ) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(
        {
          'imageUrl': imageUrl,
        },
        SetOptions(
          merge: true,
        ));
    return;
  }

  Future<app_user.User?> getUsersCredentials() async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return app_user.User.fromJson(snapshot.data());
        //as Map<String, dynamic>);

        // app_user.User.fromJson(snapshot.data());
      }
      print(snapshot);
    } catch (error) {
      print(error);
    }
  }

  Future<DocumentSnapshot> getUsersCredentials1() {
    //String? uid = firebaseAuth.currentUser?.uid.toString();

    //final appUser =
    return FirebaseFirestore.instance
        .collection('UserData')
        .doc('7dpxI6XykwaTDlUGaWzWYkCE9Md2')
        .get();
    //final snapshot1 = await appUser.get();
    //return snapshot1;
  }

  // Future<void> updateUserInfo(
  //   List<String> interests,
  // ) async {
  //   String? uid = firebaseAuth.currentUser?.uid.toString();
  //   await firebaseFirestore.doc(uid.toString()).set(
  //       {
  //         'interests': interests,
  //       },
  //       SetOptions(
  //         merge: true,
  //       ));
  //   return;
  // }
}
//FutureBuilder<DocumentSnapshot>(
//   future: users.doc(documentId).get(),
//   builder:
//       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

//     if (snapshot.hasError) {
//       return Text("Something went wrong");
//     }

//     if (snapshot.hasData && !snapshot.data!.exists) {
//       return Text("Document does not exist");
//     }

//     if (snapshot.connectionState == ConnectionState.done) {
//       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//       return Text("Full Name: ${data['full_name']} ${data['last_name']}");
//     }

//     return Text("loading");
//   },
// );
