import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/repositories/doctor/doctor_repository.dart';
import 'package:provider/provider.dart';

import './constants/theme/app_theme.dart';
import './mock/service/get_doctor_service.dart';
import './routes/app_route.dart' as route;
import 'logic/bloc/blocs.dart';
import 'logic/bloc/doctor_bloc/doctor_appointments/doctor_appointments_bloc.dart';
import 'logic/bloc/doctor_bloc/doctor_patients/doctor_patients_bloc.dart';
import 'logic/cubit/page_update/page_update_cubit.dart';
import 'logic/cubit/tab_update/tab_update_cubit.dart';
import 'logic/cubit/theme/theme_cubit.dart';
import 'logic/cubit/user_type/user_type_cubit.dart';
import 'repositories/blog/blog_repository.dart';
import 'repositories/repositories.dart';
import 'services/auth_page_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthPageProvider.instance()),
        ChangeNotifierProvider(create: (_) => GetDoctor())
      ],
      child: const MyApp(),
    ),
  );
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
        RepositoryProvider<DoctorRepository>(create: (_) => DoctorRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          //Blocs
          BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                  repository: AuthenticationRepository(),
                  userTypeCubit: UserTypeCubit())),
          BlocProvider<DoctorAppointmentsBloc>(
              create: (context) =>
                  DoctorAppointmentsBloc(doctorRepository: DoctorRepository())
                    ..add(LoadDoctorAppointments(doctorId: userId))),
          BlocProvider<DoctorPatientsBloc>(
              create: (context) =>
                  DoctorPatientsBloc(doctorRepository: DoctorRepository())
                    ..add(LoadDoctorPatients(doctorId: userId))),
          BlocProvider<BlogBloc>(
              create: (context) =>
                  BlogBloc(blogRepository: BlogRepository())..add(LoadBlogs())),
          //authentication status
          BlocProvider<AuthStatusBloc>(
              create: (context) =>
                  AuthStatusBloc(authRepository: AuthenticationRepository())
                    ..add(CheckUserStatus())),
          //Cubits
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
          BlocProvider<TabUpdateCubit>(create: (context) => TabUpdateCubit()),
          BlocProvider<PageUpdateCubit>(create: (context) => PageUpdateCubit()),
          BlocProvider<UserTypeCubit>(create: (context) => UserTypeCubit()),
        ],
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            systemStatusBarContrastEnforced: false,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
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
                        initialRoute: route.homePage);
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
                          theme: AppTheme().lightTheme,
                          themeMode: state.themeMode,
                          onGenerateRoute: route.AppRouter.generateRoute,
                          initialRoute: route.welcome);
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
