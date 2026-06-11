import 'package:saranstore/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:saranstore/feature/auth/domain/entity/user_entity.dart';
import 'package:saranstore/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<UserEntity> signup({
    required String email,
    required String password,
  }) async {
    return await remoteDatasource.signup(email: email, password: password);
  }

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    return await remoteDatasource.login(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    return await remoteDatasource.logout();
  }
}
