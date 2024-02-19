import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_screen.dart';
import 'providers/restaurant_provider.dart';

void main() {
  runApp(
    MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => RestaurantProvider(),)],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home':(context) => const HomeScreen(),
      },
    );
  }
}
