import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Data/repository/local_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final _localRepo = LocalRepository();

  Future<void> signIn(String email, String password, bool rememberMe) async {
    emit(AuthLoading());
    try {
      final user = await _localRepo.getUserByEmail(email);
      if (user == null) {
        emit(AuthFailure('User not found'));
        return;
      }

      final storedPassword = await _localRepo.getPassword(email);
      if (storedPassword != password) {
        emit(AuthFailure('Incorrect password'));
        return;
      }

      int rememberMeValue = rememberMe ? 1 : 0;
      await _localRepo.updateUser({
        'id': user['id'],
        'name': user['name'],
        'email': user['email'],
        'remember_me': rememberMeValue,
      });

      await _localRepo.setLoggedIn(true, userId: user['id']);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure('Error: $e'));
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final existingUser = await _localRepo.getUserByEmail(email);
      if (existingUser != null) {
        emit(AuthFailure('Email already exists'));
        return;
      }

      int userId = await _localRepo.insertUser({
        'name': name,
        'email': email,
        'remember_me': 1,
      });

      await _localRepo.savePassword(email, password);
      await _localRepo.setLoggedIn(true, userId: userId);
      
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure('Error: $e'));
    }
  }

  Future<void> loginWithSavedAccount(int userId) async {
    emit(AuthLoading());
    try {
      await _localRepo.setLoggedIn(true, userId: userId);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure('Error: $e'));
    }
  }
}
