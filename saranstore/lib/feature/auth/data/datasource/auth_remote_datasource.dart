import 'package:firebase_auth/firebase_auth.dart';
import 'package:saranstore/core/network/firebase_error_handler.dart';
import 'package:saranstore/feature/auth/data/model/user_model.dart';

class AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDatasource({required this.firebaseAuth});

  Future<UserModel> signup({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel.fromFirebaseUser(result.user!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler().handleError(e);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel.fromFirebaseUser(result.user!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler().handleError(e);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler().handleError(e);
    } catch (e) {
      throw e.toString();
    }
  }
}
