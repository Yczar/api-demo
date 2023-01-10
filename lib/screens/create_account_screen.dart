import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  late final TextEditingController _usernameEditingController;
  late final TextEditingController _passwordEditingController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _usernameEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Create Account Screen',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: _usernameEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username cannot be empty';
                  } else if (value.length < 4) {
                    return 'Username length cannot be less than 6';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _passwordEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty';
                  } else if (value.length < 6) {
                    return 'Password length cannot be less than 6';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _createAccount();
                    }
                  },
                  child: const Text(
                    'Create',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    try {
      final Dio dio = Dio();
      final result = await dio.post(
        'https://bookstore.demoqa.com/Account/v1/User',
        data: {
          'userName': _usernameEditingController.text,
          'password': _passwordEditingController.text,
        },
      );

      log(result.toString());
    } catch (e, s) {
      log('$e$s');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'An error occurred',
          ),
        ),
      );
    }
  }

  // Future<void> _fetchAccount() async {
  //   try {
  //     final Dio dio = Dio()
  //       ..options = BaseOptions(
  //         headers: {},
  //       );
  //     log(_usernameEditingController.text);
  //     log(_passwordEditingController.text);
  //     final result = await dio.post(
  //       'https://bookstore.demoqa.com/Account/v1/User',
  //       data: {
  //         'userName': _usernameEditingController.text,
  //         'password': _passwordEditingController.text,
  //       },
  //     );

  //     log(result.toString());
  //   } catch (e, s) {
  //     log('$e$s');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //           'An error occurred',
  //         ),
  //       ),
  //     );
  //   }
  // }
}
// /user is to create user
// /generateToken is for logging in the user
// /authorized is to verify the user is authorized

// c393e54e-bd3b-47f9-9145-d8b3990467ea
// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InBlcnNpZSIsInBhc3N3b3JkIjoiJCRQZXJzaWUxMjM0IiwiaWF0IjoxNjcyNDE5MjcyfQ.HnpQbY4MzbZ33WluNNVmW4UNzlhkXOtvqQcjeBOtD-8