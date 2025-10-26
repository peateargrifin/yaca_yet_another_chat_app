import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaca/api/fireapi.dart';

class authservice {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fire = FirebaseFirestore.instance;
  //final fireapi fire_api = fireapi();

  User? getuser() {
    return auth.currentUser;
  }

  //sigin
  Future<UserCredential> signinwithemail(String email, String passw) async {
    try {
      UserCredential usercred = await auth.signInWithEmailAndPassword(
        email: email,
        password: passw,
      );

      fire.collection('Users').doc(usercred.user!.uid).set({
        'uid': usercred.user!.uid,
        'email': email,
      });

      return usercred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signupwithemail(String email, String passw) async {
    try {
      UserCredential usercred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: passw,
      );
      fire.collection('Users').doc(usercred.user!.uid).set({
        'uid': usercred.user!.uid,
        'email': email,
      });
      return usercred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //signout

  Future<void> signout() async {
    return await auth.signOut();
  }

  signgoogle() async {
    // final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? goguser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gauth = await goguser!.authentication;

    final cred = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(cred);
  }

  //
  // Future<void> savefcmtoken(String userid) async {
  //   String? token = await fire_api.getToken();
  //   if (token != null) {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userid)
  //         .update({'fcmToken': token});
  //   }
  // }
}
