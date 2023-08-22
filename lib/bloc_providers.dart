import 'package:flutter/material.dart';
import 'package:my_daktari/logic/cubit/upload_product_data/upload_product_data_cubit.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/client_bloc/book_appointment/book_appointment_bloc.dart';
import 'package:my_daktari/logic/bloc/client_bloc/client_appointment/client_appointments_bloc.dart';
import 'package:my_daktari/logic/bloc/client_bloc/payment/payment_bloc.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/forgot_password/reset_password_bloc.dart';

import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/cubit/booking_info/booking_info_cubit.dart';
import 'package:my_daktari/logic/cubit/profile_page_view/profile_view_cubit.dart';
import 'package:my_daktari/repositories/client/ambulance/ambulance_repository.dart';
import 'package:my_daktari/repositories/client/bodyparts/body_parts_repository.dart';
import 'package:my_daktari/repositories/client/client_repository.dart';
import 'package:my_daktari/repositories/doctor/doctor_repository.dart';
import 'package:my_daktari/repositories/client/pharmacy/pharmacy_repository.dart';
import 'package:my_daktari/repositories/client/symptoms/symptoms_repository.dart';

import 'logic/bloc/shared_bloc/auth_status/auth_status_bloc.dart';
import 'logic/bloc/shared_bloc/authentication/authentication_bloc.dart';
import 'logic/bloc/client_bloc/ambulance/ambulance_bloc.dart';
import 'logic/bloc/client_bloc/blog/blog_bloc.dart';
import 'logic/bloc/client_bloc/bodyparts_bloc/body_parts_bloc.dart';
import 'logic/bloc/client_bloc/doctors_symptom/doctors_symptom_bloc.dart';
import 'logic/bloc/client_bloc/pharmacy/pharmacy_bloc.dart';
import 'logic/bloc/client_bloc/doctor_time_slots/doctor_time_slots_bloc.dart';
import 'logic/bloc/client_bloc/search_doctor/search_doctor_bloc.dart';
import 'logic/bloc/client_bloc/symptoms_bloc/symptoms_bloc.dart';
import 'logic/bloc/client_bloc/update_profile/update_profile_bloc.dart';
import 'logic/bloc/doctor_bloc/complete_profile/complete_profile_bloc.dart';
import 'logic/bloc/doctor_bloc/doctor_appointments/doctor_appointments_bloc.dart';
import 'logic/bloc/doctor_bloc/doctor_availability/doctor_availability_bloc.dart';
import 'logic/bloc/doctor_bloc/doctor_charges/doctor_charges_bloc.dart';
import 'logic/bloc/doctor_bloc/doctor_patients/doctor_patients_bloc.dart';
import 'logic/bloc/shared_bloc/cart/cart_bloc.dart';
import 'logic/bloc/shared_bloc/load_products/load_products_bloc.dart';
import 'logic/bloc/shared_bloc/otp/otp_bloc.dart';
import 'logic/bloc/shared_bloc/password_otp/password_otp_bloc.dart';
import 'logic/bloc/supplier_bloc/load_categories/load_categories_bloc.dart';
import 'logic/bloc/supplier_bloc/upload_product/upload_product_bloc.dart';
import 'logic/cubit/charges_dropdown/drop_down_cubit.dart';
import 'logic/cubit/doctor_schedules/doctor_schedule.dart';
import 'logic/cubit/file_name/file_name_cubit.dart';
import 'logic/cubit/infor_page_update/info_page_update_cubit.dart';
import 'logic/cubit/order_data/order_data_cubit.dart';
import 'logic/cubit/otp_timer/otp_timer_cubit.dart';
import 'logic/cubit/page_update/page_update_cubit.dart';
import 'logic/cubit/personal_info/personal_info_cubit.dart';
import 'logic/cubit/sign_up_helper/sign_up_helper_cubit.dart';
import 'logic/cubit/symptoms/symptoms_cubit_cubit.dart';
import 'logic/cubit/tab_update/tab_update_cubit.dart';
import 'logic/cubit/theme/theme_cubit.dart';
import 'logic/cubit/update_profile/update_profile_cubit.dart';
import 'logic/cubit/user_type/user_type_cubit.dart';
import 'repositories/shared_repositories/authentication/authentication_repository.dart';
import 'repositories/shared_repositories/blog/blog_repository.dart';
import 'repositories/shared_repositories/profile/profile_repository.dart';
import 'repositories/supplier/product/product_repository.dart';

List<SingleChildWidget> blocProviders({required BuildContext context}) {
  return [
    //Blocs
    //authentication
    BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
            repository: AuthenticationRepository(),
            userTypeCubit: UserTypeCubit())),
    BlocProvider<OtpBloc>(
        create: (context) =>
            OtpBloc(authRepository: AuthenticationRepository())),
    BlocProvider<PasswordOtpBloc>(
        create: (context) =>
            PasswordOtpBloc(authRepository: AuthenticationRepository())),
    BlocProvider<ResetPasswordBloc>(
        create: (context) => ResetPasswordBloc(
            authenticationRepository: AuthenticationRepository())),
    BlocProvider<AuthStatusBloc>(
        create: (context) =>
            AuthStatusBloc(authRepository: AuthenticationRepository())
              ..add(CheckUserStatus())),

    BlocProvider<UpdateProfileBloc>(
        create: (context) =>
            UpdateProfileBloc(repository: ProfileRepository())),

    //doctors
    BlocProvider<CompleteProfileBloc>(
        create: (context) =>
            CompleteProfileBloc(doctorRepository: DoctorRepository())),
    BlocProvider<DoctorAvailabilityBloc>(
        create: (context) =>
            DoctorAvailabilityBloc(doctorRepository: DoctorRepository())),
    BlocProvider<DoctorChargesBloc>(
        create: (context) =>
            DoctorChargesBloc(doctorRepository: DoctorRepository())),
    BlocProvider<DoctorAppointmentsBloc>(
        create: (context) =>
            DoctorAppointmentsBloc(doctorRepository: DoctorRepository())
              ..add(LoadDoctorAppointments(doctorId: userId))),
    BlocProvider<DoctorPatientsBloc>(
        create: (context) =>
            DoctorPatientsBloc(doctorRepository: DoctorRepository())
              ..add(LoadDoctorPatients(doctorId: userId))),
    //clients
    BlocProvider<SearchDoctorBloc>(
        create: (context) => SearchDoctorBloc(repository: ClientRepository())),
    BlocProvider<PaymentBloc>(
        create: (context) => PaymentBloc(repository: ClientRepository())),
    BlocProvider<BookAppointmentBloc>(
        create: (context) =>
            BookAppointmentBloc(repository: ClientRepository())),
    BlocProvider<ClientAppointmentsBloc>(
        create: (context) =>
            ClientAppointmentsBloc(repository: ClientRepository())),
    BlocProvider<DoctorTimeSlotsBloc>(
        create: (context) =>
            DoctorTimeSlotsBloc(repository: ClientRepository())),
    BlocProvider<DoctorsBySymptomsBloc>(
        create: (context) =>
            DoctorsBySymptomsBloc(repository: ClientRepository())),
    BlocProvider<DoctorsBySymptomsBloc>(
        create: (context) =>
            DoctorsBySymptomsBloc(repository: ClientRepository())),
    BlocProvider<BlogBloc>(
        create: (context) =>
            BlogBloc(blogRepository: BlogRepository())..add(LoadBlogs())),
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
    //Cubits
    BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
    BlocProvider<UploadProductDataCubit>(
        create: (context) => UploadProductDataCubit()),
    BlocProvider<BookingInfoCubit>(create: (context) => BookingInfoCubit()),
    BlocProvider<FileNameCubit>(create: (context) => FileNameCubit()),
    BlocProvider<ProfileViewCubit>(create: (context) => ProfileViewCubit()),
    BlocProvider<PersonalInfoCubit>(create: (context) => PersonalInfoCubit()),
    BlocProvider<DropChargesCubit>(create: (context) => DropChargesCubit()),
    BlocProvider<SignUpHelperCubit>(create: (context) => SignUpHelperCubit()),
    BlocProvider<TabUpdateCubit>(create: (context) => TabUpdateCubit()),
    BlocProvider<OtpTimerCubit>(create: (context) => OtpTimerCubit()),
    BlocProvider<PageUpdateCubit>(create: (context) => PageUpdateCubit()),
    BlocProvider<InfoPageUpdateCubit>(
        create: (context) => InfoPageUpdateCubit()),
    BlocProvider<UserTypeCubit>(create: (context) => UserTypeCubit()),
    BlocProvider<SymptomsCubit>(create: (context) => SymptomsCubit()),
    BlocProvider<UpdateProfileCubit>(create: (context) => UpdateProfileCubit()),
    BlocProvider<ScheduleCubit>(
      create: (context) => ScheduleCubit(schedulesConstant),
    ),
    //upload product bloc
    BlocProvider<UploadProductBloc>(
        create: (context) =>
            UploadProductBloc(repository: ProductRepository())),
    //load products bloc
    BlocProvider<LoadProductsBloc>(
        create: (context) =>
            LoadProductsBloc(productsRepository: ProductRepository())
              ..add(LoadProducts())),
    BlocProvider(create: (context) => CartBloc()..add(StartCart())),
    //load product categories bloc
    BlocProvider<LoadCategoriesBloc>(
        create: (context) =>
            LoadCategoriesBloc(CategoriesRepository: ProductRepository())
              ..add(LoadCategories())),
    //order data cubit
    BlocProvider<OrderDataCubit>(create: (context) => OrderDataCubit()),
  ];
}
