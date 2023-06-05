import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:provider/provider.dart';

import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/models/dayschedule.dart';
import 'package:my_daktari/repositories/ambulance/ambulance_repository.dart';
import 'package:my_daktari/repositories/bodyparts/body_parts_repository.dart';
import 'package:my_daktari/repositories/client/client_repository.dart';
import 'package:my_daktari/repositories/doctor/doctor_repository.dart';
import 'package:my_daktari/repositories/pharmacy/pharmacy_repository.dart';
import 'package:my_daktari/repositories/symptoms/symptoms_repository.dart';

import './constants/theme/app_theme.dart';
import './mock/service/get_doctor_service.dart';
import 'constants/routes/route.dart' as route;
import 'logic/bloc/ambulance/ambulance_bloc.dart';
import 'logic/bloc/blocs.dart';
import 'logic/bloc/bodyparts_bloc/body_parts_bloc.dart';
import 'logic/bloc/client/search_doctor/search_doctor_bloc.dart';
import 'logic/bloc/doctor_bloc/doctor_appointments/doctor_appointments_bloc.dart';
import 'logic/bloc/doctor_bloc/doctor_availability/doctor_availability_bloc.dart';
import 'logic/bloc/doctor_bloc/doctor_charges/doctor_charges_bloc.dart';
import 'logic/bloc/doctor_bloc/doctor_patients/doctor_patients_bloc.dart';
import 'logic/bloc/otp/otp_bloc.dart';
import 'logic/bloc/pharmacy/pharmacy_bloc.dart';
import 'logic/bloc/symptoms_bloc/symptoms_bloc.dart';
import 'logic/cubit/charges_dropdown/drop_down_cubit.dart';
import 'logic/cubit/doctor_schedules/doctor_schedule.dart';
import 'logic/cubit/file_name/file_name_cubit.dart';
import 'logic/cubit/infor_page_update/info_page_update_cubit.dart';
import 'logic/cubit/otp_timer/otp_timer_cubit.dart';
import 'logic/cubit/page_update/page_update_cubit.dart';
import 'logic/cubit/personal_info/personal_info_cubit.dart';
import 'logic/cubit/sign_up_helper/sign_up_helper_cubit.dart';
import 'logic/cubit/tab_update/tab_update_cubit.dart';
import 'logic/cubit/theme/theme_cubit.dart';
import 'logic/cubit/user_type/user_type_cubit.dart';
import 'repositories/blog/blog_repository.dart';
import 'repositories/repositories.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => GetDoctor())],
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
            create: (_) => AuthenticationRepository()),
        RepositoryProvider<DoctorRepository>(create: (_) => DoctorRepository()),
        RepositoryProvider<ClientRepository>(create: (_) => ClientRepository()),
        RepositoryProvider<AmbulanceRepository>(
            create: (_) => AmbulanceRepository()),
        RepositoryProvider<PharmacyRepository>(
            create: (_) => PharmacyRepository()),
        RepositoryProvider<BodyPartsRepository>(
            create: (_) => BodyPartsRepository()),
        RepositoryProvider<SymptomsRepository>(
            create: (_) => SymptomsRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          //Blocs
          BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                  repository: AuthenticationRepository(),
                  userTypeCubit: UserTypeCubit())),
          BlocProvider<OtpBloc>(
              create: (context) =>
                  OtpBloc(authRepository: AuthenticationRepository())),
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
          BlocProvider<SearchDoctorBloc>(
              create: (context) =>
                  SearchDoctorBloc(repository: ClientRepository())),
          BlocProvider<PharmacyBloc>(
              create: (context) =>
                  PharmacyBloc(pharmacyRepository: PharmacyRepository())
                    ..add(LoadPharmacy())),
          BlocProvider<AmbulanceBloc>(
              create: (context) =>
                  AmbulanceBloc(ambulanceRepository: AmbulanceRepository())
                    ..add(LoadAmbulances())),
          BlocProvider<BodyPartsBloc>(
              create: (context) =>
                  BodyPartsBloc(bodyPartsRepository: BodyPartsRepository())
                    ..add(LoadBodyParts())),
          BlocProvider<SymptomsBloc>(
              create: (context) =>
                  SymptomsBloc(symptomsRepository: SymptomsRepository())),
          //authentication status
          BlocProvider<AuthStatusBloc>(
              create: (context) =>
                  AuthStatusBloc(authRepository: AuthenticationRepository())
                    ..add(CheckUserStatus())),
          BlocProvider<DoctorAvailabilityBloc>(
              create: (context) =>
                  DoctorAvailabilityBloc(doctorRepository: DoctorRepository())),
          BlocProvider<DoctorChargesBloc>(
              create: (context) =>
                  DoctorChargesBloc(doctorRepository: DoctorRepository())),

          //Cubits
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
          BlocProvider<FileNameCubit>(create: (context) => FileNameCubit()),
          BlocProvider<PersonalInfoCubit>(
              create: (context) => PersonalInfoCubit()),
          BlocProvider<DropChargesCubit>(
              create: (context) => DropChargesCubit()),
          BlocProvider<SignUpHelperCubit>(
              create: (context) => SignUpHelperCubit()),
          BlocProvider<TabUpdateCubit>(create: (context) => TabUpdateCubit()),
          BlocProvider<OtpTimerCubit>(create: (context) => OtpTimerCubit()),
          BlocProvider<PageUpdateCubit>(create: (context) => PageUpdateCubit()),
          BlocProvider<InfoPageUpdateCubit>(
              create: (context) => InfoPageUpdateCubit()),
          BlocProvider<UserTypeCubit>(create: (context) => UserTypeCubit()),
          BlocProvider<ScheduleCubit>(
            create: (context) => ScheduleCubit(daysOfWeek.map((day) {
              return DaySchedule(
                  day: day,
                  isEnabled: true,
                  startTime: timeIntervals.first,
                  endTime: timeIntervals.first);
            }).toList()),
          ),
        ],
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
                print('**********************');
                print(authState.profileCompleted);
                print(authState.userType);
                print('**********************');
                return BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'My Daktari',
                        theme: AppTheme().lightTheme,
                        themeMode: state.themeMode,
                        onGenerateRoute: route.AppRouter.generateRoute,
                        initialRoute: authState.userType == UserType.client
                            ? route.homePage
                            : authState.profileCompleted
                                ? route.homePage
                                : route.personalInfo);
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
