import 'package:ecommerce_custom_backend/models/usermodel.dart';
import 'package:flutter/material.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthErrorState extends AuthState {
  String err;

  AuthErrorState({required this.err});
}

class AuthLoadingState extends AuthState {}

class AuthDoneState extends AuthState {
  UserModel user;

  AuthDoneState({required this.user});
}
