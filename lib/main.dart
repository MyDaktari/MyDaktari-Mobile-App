import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import './constants/theme/app_theme.dart';
import './mock/service/get_doctor_service.dart';
import './routes/app_route.dart' as route;
import 'logic/bloc/blocs.dart';
import 'logic/cubit/page_update/page_update_cubit.dart';
import 'logic/cubit/theme/theme_cubit.dart';
import 'logic/cubit/user_type/user_type_cubit.dart';
import 'repositories/blog/blog_repository.dart';
import 'repositories/repositories.dart';
import 'services/auth_page_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthPageProvider.instance()),
    ChangeNotifierProvider(create: (_) => GetDoctor()),
    // ChangeNotifierProvider(create: (_) => ThemeNotifier(ThemeMode.light))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
            create: (_) => AuthenticationRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          //Blocs
          BlocProvider<AuthenticationBloc>(
              create: (context) =>
                  AuthenticationBloc(repository: AuthenticationRepository())),
          BlocProvider<BlogBloc>(
              create: (context) =>
                  BlogBloc(blogRepository: BlogRepository())..add(LoadBlogs())),
          //Cubits
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
          BlocProvider<PageUpdateCubit>(create: (context) => PageUpdateCubit()),
          BlocProvider<UserTypeCubit>(create: (context) => UserTypeCubit()),
        ],
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            systemStatusBarContrastEnforced: false,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'My Daktari',
                theme: AppTheme().lightTheme,
                themeMode: state.themeMode,
                onGenerateRoute: route.AppRouter.generateRoute,
                initialRoute: route.welcome,
              );
            },
          ),
        ),
      ),
    );
  }
}
