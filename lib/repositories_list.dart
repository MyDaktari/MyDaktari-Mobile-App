import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import 'repositories/client/ambulance/ambulance_repository.dart';
import 'repositories/client/bodyparts/body_parts_repository.dart';
import 'repositories/client/client_repository.dart';
import 'repositories/client/pharmacy/pharmacy_repository.dart';
import 'repositories/client/symptoms/symptoms_repository.dart';
import 'repositories/doctor/doctor_repository.dart';
import 'repositories/shared_repositories/authentication/authentication_repository.dart';

List<SingleChildWidget> repositoriesList = [
  RepositoryProvider<AuthenticationRepository>(
      create: (_) => AuthenticationRepository()),
  RepositoryProvider<DoctorRepository>(create: (_) => DoctorRepository()),
  RepositoryProvider<ClientRepository>(create: (_) => ClientRepository()),
  RepositoryProvider<AmbulanceRepository>(create: (_) => AmbulanceRepository()),
  RepositoryProvider<PharmacyRepository>(create: (_) => PharmacyRepository()),
  RepositoryProvider<BodyPartsRepository>(create: (_) => BodyPartsRepository()),
  RepositoryProvider<SymptomsRepository>(create: (_) => SymptomsRepository())
];
