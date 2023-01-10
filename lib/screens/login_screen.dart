import 'package:api_demo/providers/login/login_provider.dart';
import 'package:api_demo/providers/login/login_state.dart';
import 'package:api_demo/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameEditingController;
  late final TextEditingController _passwordEditingController;
  late final GlobalKey<FormState> _formKey;
  late final LoginProvider _loginProvider;

  @override
  void initState() {
    super.initState();

    /// [controllers]
    _usernameEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();

    /// [keys]
    _formKey = GlobalKey<FormState>();

    /// [providers]
    _loginProvider = LoginProvider()
      ..addListener(
        () {
          final state = _loginProvider.currentState;
          if (state is LoginStateLoaded) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
            );
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    // final state = context.watch<LoginProvider>().currentState;
    return ListenableProvider.value(
      value: _loginProvider,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Login Screen',
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
                Selector<LoginProvider, LoginState>(
                  selector: (
                    BuildContext context,
                    LoginProvider provider,
                  ) =>
                      provider.currentState,
                  builder: (
                    BuildContext context,
                    LoginState state,
                    Widget? child,
                  ) =>
                      SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _loginProvider.login(
                            _usernameEditingController.text,
                            _passwordEditingController.text,
                          );
                          // _login();
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text(
                          //       'An error occurred',
                          //     ),
                          //   ),
                          // );
                        }
                      },
                      child: state is LoginStateLoading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Login',
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginProvider.removeListener(() {});
    _loginProvider.dispose();
    _usernameEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }
}
// Username: flutterdash
// Password: flutterDash$1234


// Auth Provider(User, anything that has to deal with authentication)
// Login Provider
// Create Account Provider 