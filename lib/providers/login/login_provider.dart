// login user
// update UI whenever the API is loading
// update UI whenever there is an error

import 'dart:developer';

import 'package:api_demo/providers/login/login_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//
class LoginProvider extends ChangeNotifier {
  LoginProvider() {
    _currentState = LoginStateInitial();
  }
  late LoginState _currentState;
  LoginState get currentState => _currentState;
  // currentState means what is happening in the provider currently for example loading, loaded, error

  ///
  Future<void> login(
    String username,
    String password,
  ) async {
    try {
      // load
      _emit(LoginStateLoading());
      final Dio dio = Dio();
      final result = await dio.post(
        'https://bookstore.demoqa.com/Account/v1/GenerateToken',
        data: {
          'userName': username,
          'password': password,
        },
      );
      if (result.statusCode == 200) {
        _emit(LoginStateLoaded());
      } else {
        _emit(LoginStateError('an error occurred'));
      }
      // success or failure
      log(result.toString());
    } catch (e, s) {
      _emit(LoginStateError('an error occurred'));
      // failure
      log('$e$s');
    }
  }

  void _emit(LoginState state) {
    _currentState = state;
    notifyListeners();
  }

  @override
  void dispose() {
    _currentState = LoginStateInitial();
    super.dispose();
  }
}
