import 'package:saranstore/feature/auth/domain/entity/user_entity.dart';
import 'package:saranstore/feature/auth/domain/repository/auth_repository.dart';

class SignupUsecase {
  final AuthRepository repository;
  SignupUsecase({required this.repository});

  Future<UserEntity> call({
    required String email,
    required String password,
  }) async {
    return await repository.signup(email: email, password: password);
  }
}
