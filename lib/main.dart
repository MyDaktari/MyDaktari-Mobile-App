import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './constants/theme/app_theme.dart';
import './mock/service/get_doctor_service.dart';
import './presentations/auth/services/auth_page_provider.dart';
import './routes/app_route.dart' as route;
import 'constants/theme/theme_mode.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthPageProvider.instance()),
    ChangeNotifierProvider(create: (_) => GetDoctor()),
    ChangeNotifierProvider(create: (_) => ThemeNotifier(ThemeMode.light))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Daktari',
        theme: AppTheme().lightTheme,
        themeMode: themeNotifier.getThemeMode(),
        onGenerateRoute: route.AppRouter.generateRoute,
        initialRoute: route.welcome,
      ),
    );
  }
}
