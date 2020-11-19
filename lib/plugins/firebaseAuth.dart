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
    userModel = UserModel(
        currentUser.uid,
        currentUser.displayName,
        currentUser.email,
        currentUser.photoURL,
        currentUser.phoneNumber,
        'google');
    return true;
  }
  return false;
}

Future signOutGoogle() async {
  await googleSignIn.signOut();
}

Future createUserWithEmailAndPassword(var email, var password) async {
  try {
    userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    userModel = UserModel(
        userCredential.user.uid,
        userCredential.user.displayName,
        userCredential.user.email,
        userCredential.user.photoURL,
        userCredential.user.phoneNumber,
        'default');

    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('weak-password');
      return 'Senha muito fraca, digite uma senha mais forte';
    } else if (e.code == 'email-already-in-use') {
      print('email-already-in-use');
      return 'Este e-mail já está em uso';
    }
  } catch (e) {
    return 'Erro ao cadastrar usuario';
  }
}

Future signInWithEmailAndPassword(var email, var password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    userModel = UserModel(
        userCredential.user.uid,
        userCredential.user.displayName,
        userCredential.user.email,
        userCredential.user.photoURL != null
            ? userCredential.user.photoURL
            : "https://i.imgur.com/2lXx3B3.png",
        userCredential.user.phoneNumber,
        'default');

    return true;
  } on FirebaseAuthException catch (e) {
    return false;
  }
}

Future signOut() async {
  await FirebaseAuth.instance.signOut();
}
