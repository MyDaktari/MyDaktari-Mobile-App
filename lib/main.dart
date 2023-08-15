import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/bloc_providers.dart';
import 'package:my_daktari/constants/enums.dart';
import './constants/theme/app_theme.dart';
import 'constants/route.dart' as route;
import 'logic/bloc/auth_status/auth_status_bloc.dart';
import 'logic/cubit/theme/theme_cubit.dart';
import 'logic/cubit/user_type/user_type_cubit.dart';
import 'repositories_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repositoriesList,
      child: MultiBlocProvider(
        providers: blocProviders(context: context),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              systemStatusBarContrastEnforced: false,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent),
          child: BlocConsumer<AuthStatusBloc, AuthStatusState>(
            listener: (context, authState) {
              if (authState is UserAuthenticated) {
                context
                    .read<UserTypeCubit>()
                    .switchToUser(userType: authState.userType);
              }
            },
            builder: (context, authState) {
              if (authState is UserAuthenticated) {
                return BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'My Daktari',
                        theme: AppTheme().lightTheme,
                        themeMode: state.themeMode,
                        onGenerateRoute: route.AppRouter.generateRoute,
                        initialRoute: authState.optVerified
                            ? authState.userType == UserType.client
                                ? route.homeScreen
                                : authState.userType == UserType.supplier
                                    ? route.supplierHomeScreen
                                    : authState.profileCompleted
                                        ? route.homeScreen
                                        : route.personalInfo
                            : route.welcomeScreen);
                  },
                );
              } else {
                //!do not remove this builder
                return Builder(builder: (context) {
                  return BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          title: 'My Daktari',
                          onGenerateRoute: route.AppRouter.generateRoute,
                          initialRoute: route.welcomeScreen);
                    },
                  );
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
