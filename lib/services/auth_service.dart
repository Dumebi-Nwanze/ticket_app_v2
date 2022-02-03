import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_app_v2/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUp({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
  }) async {
    String result = "";
    try {
      //creating account with email and password
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
        uid: cred.user!.uid,
        email: email,
        firstname: firstname,
        lastname: lastname,
      );
      //pushing usermodel to firestore
      _firestore
          .collection("users")
          .doc(cred.user!.uid)
          .set(userModel.toJson());
      result = "success";
    } catch (e) {
      //return error message
      result = e.toString();
    }
    return result;
  }

//sign In method
  Future<String> signIn(
      {required String email, required String password}) async {
    String result = "";
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      result = "success";
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  //sign out function
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
