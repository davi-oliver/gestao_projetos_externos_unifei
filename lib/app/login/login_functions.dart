import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
// import 'package:google_sign_in/google_sign_in.dart';

TextEditingController emailcontroller = TextEditingController();
TextEditingController senhacontroller = TextEditingController();

class LoginFunctions {
  BuildContext context;
  LoginFunctions(this.context);

  Future loginWithEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: emailcontroller.text, password: senhacontroller.text);
      var token = user.user!.getIdToken();
      if (user.user != null) {
        print("tokenId: $token");
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: senhacontroller.text);

      final notesReference = FirebaseDatabase.instance
          .ref()
          .child('userProfile/${user.user!.uid}');

      await notesReference
          .update({'email': user.user!.email, 'tipo_usuario': 1});
      var token = user.user!.getIdToken();

      if (user.user != null) {
        print("tokenId: $token");
        return true;
      } else {
        return false;
      }
    }
  }

  // Future signGoogle() async {
  //   try {
  //     GoogleSignIn _googleSignIn = GoogleSignIn();
  //     // Trigger the authentication flow
  //     GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  //     // Obtain the auth details from the request
  //     GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     UserCredential user =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     final notesReference = FirebaseDatabase.instance
  //         .ref()
  //         .child('userProfile/${user.user!.uid}');
  //     await notesReference.update({
  //       'name': user.user!.displayName,
  //       'email': user.user!.providerData[0].email,
  //       'photo': user.user!.photoURL,
  //       'tipo_usuario': "0"
  //     });
  //     return true;
  //   } on Exception catch (e) {
  //     print("deu ruim: $e");
  //     return false;
  //   }
  // }
}
