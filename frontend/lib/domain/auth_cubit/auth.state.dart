abstract class AuthState {}

class AuthInitalState extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCompleteState extends AuthState {
  final key;
  AuthCompleteState({required this.key});
}

class AuthErrorState extends AuthState {
  String error;
  AuthErrorState({required this.error});
}
