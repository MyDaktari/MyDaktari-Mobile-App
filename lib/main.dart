import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth/services/auth_page_provider.dart';
import 'routes/app_route.dart' as route;

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthPageProvider.instance())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Daktari',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: route.AppRouter.generateRoute,
      initialRoute: route.welcome,
    );
  }
}
