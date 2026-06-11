import 'package:saranstore/feature/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signup({required String email,required String password});
  Future<UserEntity> login({required String email,required String password});
  Future<void> logout();
}