import 'dart:developer';

import 'package:api_demo/screens/create_account_screen.dart';
import 'package:api_demo/screens/login_screen.dart';
import 'package:api_demo/services/hive_service.dart';
import 'package:flutter/material.dart';

class WelcomeSCreen extends StatefulWidget {
  const WelcomeSCreen({super.key});

  @override
  State<WelcomeSCreen> createState() => _WelcomeSCreenState();
}

class _WelcomeSCreenState extends State<WelcomeSCreen> {
  @override
  void initState() {
    super.initState();
    setAndGetData();
  }

  Future<void> setAndGetData() async {
    final hiveService = HiveService();
    await hiveService.storeData(
      boxName: 'user',
      data: {
        'name': 'czar',
        'title': 'bro',
      },
    );
    Future.delayed(const Duration(seconds: 3), () async {
      final fetchedData = await hiveService.getData(
        'user',
        ['name', 'title'],
      );
      log(fetchedData.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: const Text(
                'Login',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CreateAccountScreen(),
                  ),
                );
              },
              child: const Text(
                'Create Account',
              ),
            )
          ],
        ),
      ),
    );
  }
}
