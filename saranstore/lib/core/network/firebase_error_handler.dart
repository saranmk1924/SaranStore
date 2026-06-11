import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {

  String handleError(FirebaseAuthException e){
    switch(e.code){
      case 'invalid-email':
        return 'Invalid email address';

      case 'email-already-in-use':
        return 'Email already registered';

      case 'weak-password':
        return 'Password is too weak';

      case 'user-not-found':
        return 'User not found';

      case 'wrong-password':
        return 'Incorrect password';

      case 'invalid-credential':
        return 'Invalid email or password';

      case 'user-disabled':
        return 'User account has been disabled';

      case 'too-many-requests':
        return 'Too many attempts. Try again later';

      case 'network-request-failed':
        return 'No internet connection';

      default:
        return e.message ?? 'Something went wrong';
    }
  }
}