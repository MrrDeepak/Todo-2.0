import 'package:flutter/material.dart';
import 'package:frontend/viewmodal/provider.dart';
import 'package:frontend/view/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) =>EmployeeProvider() ,)
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey,
        // brightness: Brightness.dark
        ),
        //useMaterial3: true,
      ),
      home: const ProductListView(),
    );
  }
}
