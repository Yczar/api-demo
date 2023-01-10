import 'dart:io';

import 'package:api_demo/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  await Hive.initFlutter(appDocPath);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API DEMO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeSCreen(),
    );
  }
}

//                 |______________|
//                 | Material App |     - Auhthentication           
//                 |______________|
//                        |      
//                        |  
//                 |________________|
//                 | Welcome Screen |                
//                 |________________|
//          Login                        Create Account
// class 1 class 2 class 3 class 4      class 5 class 6 class 7 class 8
//
//
//class 10 class 12 class 13
//
//
//

/// CRUD
/// C - Create
/// R - Read
/// U - Update
/// D - Delete
/// 
/// HTTP Methods
/// 
/// GET
/// POST
/// PUT
/// DELETE
/// 
/// 
/// Web, Mobile, Desktop, 