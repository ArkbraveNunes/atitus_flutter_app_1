import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();
UserCredential userCredential;

Future signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    final User currentUser = _auth.currentUser;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    assert(user.uid == currentUser.uid);
    userModel = UserModel(currentUser.uid, currentUser.displayName,
        currentUser.email, currentUser.photoURL, currentUser.phoneNumber);
    return true;
  }
  return false;
}

Future signOutGoogle() async {
  await googleSignIn.signOut();
}
