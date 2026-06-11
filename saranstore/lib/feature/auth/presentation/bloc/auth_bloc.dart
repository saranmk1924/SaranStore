import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/feature/auth/domain/usecase/login_usecase.dart';
import 'package:saranstore/feature/auth/domain/usecase/logout_usecase.dart';
import 'package:saranstore/feature/auth/domain/usecase/signup_usecase.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_event.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase signupUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  AuthBloc({
    required this.signupUsecase,
    required this.loginUsecase,
    required this.logoutUsecase,
  }) : super(AuthInitial()) {
    on<SignupEvent>(_signup);
    on<LoginEvent>(_login);
    on<LogoutEvent>(_logout);
  }

  Future<void> _signup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await signupUsecase(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await loginUsecase(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await logoutUsecase();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
