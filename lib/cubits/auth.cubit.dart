import 'package:ecommerce_custom_backend/cubits/states/auth.state.dart';
import 'package:ecommerce_custom_backend/models/usermodel.dart';
import 'package:ecommerce_custom_backend/services/auth.service.dart';
import 'package:ecommerce_custom_backend/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  final AuthService _auth = AuthService();

  UserModel user = UserModel(
      token: "", username: "", email: "", phn: "", addr: "", type: "");

  signInUser(String email, String pass) async {
    emit(AuthLoadingState());
    try {
      final Map? response = await _auth.signInUser(email, pass);

      if (response == null) {
        emit(AuthErrorState(err: "Server Issue"));
      } else {
        bool authenticate = response["authenticate"];

        if (authenticate) {
          user = UserModel.fromJson(response);
          emit(AuthDoneState(user: user));
        } else {
          emit(AuthErrorState(err: response["mssg"]));
        }
      }
    } catch (e) {
      emit(AuthErrorState(err: e.toString()));
    }
  }

  signUpUser(String username, String email, String pass, String type,
      BuildContext context) async {
    emit(AuthLoadingState());
    try {
      final Map? response = await _auth.signupUser(username, email, pass, type);
      if (response == null) {
        emit(AuthErrorState(err: "Server Issue"));
      } else {
        bool authenticate = response["authenticate"];
        if (!authenticate) {
          emit(AuthErrorState(err: response["mssg"]));
        } else {
          user = UserModel.fromJson(response);
          emit(AuthDoneState(user: user));
        }
      }
    } catch (e) {
      emit(AuthErrorState(err: e.toString()));
    }
  }

  saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool setted = await pref.setString("token", token);
    if (setted) {
      return true;
    }

    return false;
  }

  getTheUser(String token) async {
    UserModel user = await _auth.getTheUser(token);
    print(user.email);
    print(user.token);
    return user;
  }
}
