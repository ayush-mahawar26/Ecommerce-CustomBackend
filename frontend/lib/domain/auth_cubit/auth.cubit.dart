import 'dart:convert';
import 'package:cache_manager/core/write_cache_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/api/api.connection.dart';
import 'package:frontend/domain/auth_cubit/auth.state.dart';

class AuthenticationCubit extends Cubit<AuthState> {
  AuthenticationCubit(AuthState initialState) : super(AuthInitalState());

  ConnectApi connectApi = ConnectApi();

  Future signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(AuthLoading());

    try {
      if (email == "" || password == "") {
        emit(AuthErrorState(error: "Fill Your Credential"));
      } else {
        final body = await connectApi.loginUser(email, password);

        final json = await jsonDecode(body);
        String auth = json["authenticate"];
        final mssg = json["message"];

        if (auth == "false") {
          emit(AuthErrorState(error: mssg));
        } else {
          emit(AuthCompleteState(key: mssg));
          WriteCache.setString(key: "jwt", value: mssg);
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/home", (route) => false);
        }
      }
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  Future createUser(
      {required String email,
      required String pass,
      required BuildContext context}) async {
    emit(AuthLoading());
    try {
      if (email == "" || pass == "") {
        emit(AuthErrorState(error: "Fill Your Credential"));
      } else {
        final body = await connectApi.createUser(email, pass);

        print(body);

        Map jsonResponse = jsonDecode(body);
        final String isAuthenticate = jsonResponse["authenticate"];
        final String mssg = jsonResponse["message"];

        print(jsonResponse);

        if (isAuthenticate == "false") {
          emit(AuthErrorState(error: mssg));
        } else {
          emit(AuthCompleteState(key: mssg));
          WriteCache.setString(key: "jwt", value: mssg);
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/home", (route) => false);
        }
      }
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
